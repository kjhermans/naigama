use libnaie::naig_engine::NaigEngine;
use libnaie::naig_captree::NaigCapTree;
use libnaig::naig_error::NaigError;
use crate::naig_compiler_set::NaigCompilerSet;
use crate::naig_compiler_state::NaigCompilerState;
use crate::naig_compiler_options::NaigCompilerOptions;

pub struct NaigCompiler
{
  engine : NaigEngine,
}

impl NaigCompiler
{
  pub fn new
    ()
    -> NaigCompiler
  {
    let bytes = include_bytes!("grammar.byc").to_vec();
    return NaigCompiler {
      engine : NaigEngine::new(bytes),
    };
  }

  pub fn compile
    (&self, grammar : & String, options : NaigCompilerOptions)
    -> Result<String, NaigError>
  {
    let bytes = grammar.as_bytes().to_vec();
    let r = self.engine.run(& bytes);
    match r {
      Ok(outcome) => {
        let mut tree = NaigCapTree::new(& bytes, & outcome.captures);
        let mut state = NaigCompilerState::new(options);
        tree.remove(crate::naig_slotmap::_CMPSLT_S_);
        tree.remove(crate::naig_slotmap::_CMPSLT___PREFIX_);
        tree.remove(crate::naig_slotmap::_CMPSLT_COMMENT_);
        tree.remove(crate::naig_slotmap::_CMPSLT_END_);
        tree.remove(crate::naig_slotmap::_CMPSLT_LEFTARROW_);
        tree.remove(crate::naig_slotmap::_CMPSLT_OR_);
        tree.remove(crate::naig_slotmap::_CMPSLT_BOPEN_);
        tree.remove(crate::naig_slotmap::_CMPSLT_BCLOSE_);
        tree.remove(crate::naig_slotmap::_CMPSLT_CBOPEN_);
        tree.remove(crate::naig_slotmap::_CMPSLT_CBCLOSE_);
        tree.remove(crate::naig_slotmap::_CMPSLT_ABOPEN_);
        tree.remove(crate::naig_slotmap::_CMPSLT_ABCLOSE_);
        tree.remove(crate::naig_slotmap::_CMPSLT_COLON_);
        NaigCompiler::compile_top(& tree, & mut state);
        if state.firstrule.len() != 0
        {
          state.output = format!(
            "  call __RULE_{}\n  end 0\n\n{}\n"
            , state.firstrule
            , state.output
          );
        }
        return Ok(state.output);
      },
      Err(error) => { return Err(error); },
    }
  }

  fn compile_top
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let grammar = tree.first_child();
    for i in 0 .. grammar.children.len()
    {
      if grammar.children[ i ].slot
          == crate::naig_slotmap::_CMPSLT_DEFINITION_
      {
        NaigCompiler::definition(& grammar.children[ i ], state);
      } else if grammar.children[ i ].slot
                 == crate::naig_slotmap::_CMPSLT_EXPRESSION_
      {
        state.currentrule = "DEFAULT".to_string();
        NaigCompiler::expression(& grammar.children[ i ], state);
      }
    }
  }

  fn definition
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    if tree.children.len() == 1
       && tree.first_child().slot == crate::naig_slotmap::_CMPSLT_RULE_
    {
      NaigCompiler::rule(tree.first_child(), state);
    }
  }

  fn rule
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let rulename =
      String::from_utf8(tree.first_child().content.clone()).unwrap();
    if state.firstrule.len() == 0
    {
      state.firstrule = rulename.clone();
    }
    if state.options.generate_traps {
      state.append("  trap\n");
    }
    state.append_string(format!("__RULE_{}:\n", rulename));
    if state.options.capture_per_rule {
      let slot = state.capture(tree);
      state.append_string(format!("  opencapture {}\n", slot));
      NaigCompiler::expression(& tree.children[1], state);
      state.append_string(format!("  closecapture {}\n", slot));
    } else {
      NaigCompiler::expression(& tree.children[1], state);
    }
    state.append_string(format!("  ret -- from rule '{}'\n", rulename));
    if state.options.generate_traps {
      state.append("  trap\n");
    }
  }

  fn expression
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let child = tree.first_child();

    if child.slot == crate::naig_slotmap::_CMPSLT_ALTERNATIVES_
    {
      let label1 = format!("__{}_catch_{}", state.currentrule, state.counter);
      let label2 = format!("__{}_out_{}", state.currentrule, state.counter + 1);
      state.counter += 2;
      state.append_string(format!("  catch {}\n", label1));
      NaigCompiler::terms(child.first_child(), state);
      state.append_string(format!("  commit {}\n", label2));
      state.append_string(format!("{}:\n", label1));
      NaigCompiler::expression(child.last_child(), state);
      state.append_string(format!("{}:\n", label2));
    } else if child.slot == crate::naig_slotmap::_CMPSLT_TERMS_
    {
      NaigCompiler::terms(child, state);
    } else if child.slot == crate::naig_slotmap::_CMPSLT_TERM_
    {
      NaigCompiler::term(child, state);
    }
  }

  fn terms
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    for i in 0 .. tree.children.len()
    {
      if tree.children[ i ].slot == crate::naig_slotmap::_CMPSLT_TERM_
      {
        NaigCompiler::term(& tree.children[ i ], state);
      }
    }
  }

  fn term
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let child = tree.first_child();
    if child.slot == crate::naig_slotmap::_CMPSLT_SCANMATCHER_
    {
      NaigCompiler::term_scanmatcher(child, state);
    } else if tree.last_child().slot == crate::naig_slotmap::_CMPSLT_QUANTIFIER_
    {
      NaigCompiler::term_quantified(child, state);
    } else {
      NaigCompiler::matcher(child.first_child(), state);
    }
  }

  fn term_scanmatcher
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let lab = state.counter;
    let opr = tree.first_child().to_string();
    state.counter += 1;
    state.append_string(format!("  catch __scan_{}\n", lab));
    NaigCompiler::matcher(& tree.children[ 1 ], state);
    if opr.eq("&")
    {
      state.append_string(format!("  backcommit __scan_out_{}\n", lab));
      state.append_string(format!("__scan_{}:\n", lab));
      state.append               ("  fail\n");
      state.append_string(format!("__scan_out_{}:\n", lab));
    } else {
      state.append               ("  failtwice\n");
      state.append_string(format!("__scan_{}:\n", lab));
    }
  }

  fn term_quantified
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
  }

  fn matcher
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let child = tree.first_child();
    match child.slot
    {
      crate::naig_slotmap::_CMPSLT_ANY_ => { NaigCompiler::match_any(state); },
      crate::naig_slotmap::_CMPSLT_SET_ => { NaigCompiler::match_set(tree, state); },
      crate::naig_slotmap::_CMPSLT_STRING_ => { NaigCompiler::match_string(tree, state); },
      crate::naig_slotmap::_CMPSLT_BITMASK_ => { NaigCompiler::match_bitmask(tree, state); },
      crate::naig_slotmap::_CMPSLT_HEXLITERAL_ => { NaigCompiler::match_hexliteral(tree, state); },
      crate::naig_slotmap::_CMPSLT_VARCAPTURE_ => { NaigCompiler::match_varcapture(tree, state); },
      crate::naig_slotmap::_CMPSLT_CAPTURE_ => { NaigCompiler::match_capture(tree, state); },
      crate::naig_slotmap::_CMPSLT_GROUP_ => { NaigCompiler::match_group(tree, state); },
      crate::naig_slotmap::_CMPSLT_MACRO_ => { NaigCompiler::match_macro(tree, state); },
      crate::naig_slotmap::_CMPSLT_VARREFERENCE_ => { NaigCompiler::match_varreference(tree, state); },
      crate::naig_slotmap::_CMPSLT_REFERENCE_ => { NaigCompiler::match_reference(tree, state); },
      _ => { },
    }
  }

  fn match_any
    (state : & mut NaigCompilerState)
  {
    state.append("  any\n");
  }

  fn match_set
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
  }

  fn match_string
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
  }

  fn match_bitmask
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
  }

  fn match_hexliteral
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
  }

  fn match_varcapture
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let varname = tree.first_child().to_string();
    let slot = state.capture(tree);
    state.var_put(varname, slot);
    state.append_string(format!("  opencapture {}\n", slot));
    NaigCompiler::expression(tree.first_child(), state);
    state.append_string(format!("  closecapture {}\n", slot));
  }

  fn match_capture
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let slot = state.capture(tree);
    state.append_string(format!("  opencapture {}\n", slot));
    NaigCompiler::expression(tree.first_child(), state);
    state.append_string(format!("  closecapture {}\n", slot));
  }

  fn match_group
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    NaigCompiler::expression(tree.first_child(), state);
  }

  fn match_macro
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
    let mcroni = tree.first_child().to_string();
    let mut set = NaigCompilerSet::new();
    if mcroni.eq("%s")
    {
      set.set_range(9, 13);
      set.set(32);
    }
    else if mcroni.eq("%w")
    {
      set.set_range(65, 90);
      set.set_range(97, 122);
    }
    else if mcroni.eq("%n")
    {
      set.set_range(48, 57);
    }
    else if mcroni.eq("%a")
    {
      set.set_range(48, 57);
      set.set_range(65, 90);
      set.set_range(97, 122);
    }
    else if mcroni.eq("%r")
    {
      set.set_range(32, 126);
    }
    state.append_string(format!("  set {}\n", set.to_string()));
  }

  fn match_varreference
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let varname = tree.first_child().to_string();
    let opt = state.var_get(varname.clone());
    match opt
    {
      Some(slot) => { state.append_string(format!("  var {}\n", slot)); return Ok(()); },
      None => return Err(NaigError::compiler(format!("Could not resolve variable '{}'", varname))),
    }
  }

  fn match_reference
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
  {
  }
}
