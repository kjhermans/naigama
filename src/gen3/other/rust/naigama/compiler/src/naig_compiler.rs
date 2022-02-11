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
        tree.remove(crate::naig_slotmap::_CMPSLT_COMMENT_);
        tree.remove(crate::naig_slotmap::_CMPSLT_MULTILINECOMMENT_);
        tree.remove(crate::naig_slotmap::_CMPSLT___PREFIX_);
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
        NaigCompiler::compile_top(& tree, & mut state)?;
        if state.firstrule.len() != 0
        {
          state.output = format!(
            "  call __RULE_{}\n  end 0\n\n{}\n"
            , state.firstrule
            , state.output
          );
        } else {
          state.output = format!(
            "{}\n  end 0\n"
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
    -> Result< (), NaigError >
  {
    let grammar = tree.first_child();
    for i in 0 .. grammar.children.len()
    {
      if grammar.children[ i ].slot
          == crate::naig_slotmap::_CMPSLT_DEFINITION_
      {
        NaigCompiler::definition(& grammar.children[ i ], state)?;
      }
      else if grammar.children[ i ].slot
               == crate::naig_slotmap::_CMPSLT_SINGLE_EXPRESSION_
      {
        state.currentrule = "DEFAULT".to_string();
        NaigCompiler::expression(& grammar.children[ i ].first_child(), state)?;
      }
    }
    return Ok(());
  }

  fn definition
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    if tree.children.len() == 1
       && tree.first_child().slot == crate::naig_slotmap::_CMPSLT_RULE_
    {
      NaigCompiler::rule(tree.first_child(), state)
    }
    else
    {
      panic!("Token error");
    }
  }

  fn rule
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
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
    if state.prefix
    {
      state.append("  call __RULE___prefix\n");
    }
    if rulename.eq("__prefix")
    {
      state.prefix = true;
    }
    if state.options.capture_per_rule {
      let slot = state.capture(tree);
      state.append_string(format!("  opencapture {}\n", slot));
      NaigCompiler::expression(& tree.children[1], state)?;
      state.append_string(format!("  closecapture {}\n", slot));
    } else {
      NaigCompiler::expression(& tree.children[1], state)?;
    }
    state.append_string(format!("  ret -- from rule '{}'\n", rulename));
    if state.options.generate_traps {
      state.append("  trap\n");
    }
    return Ok(());
  }

  fn expression
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let child = tree.first_child();

    if child.slot == crate::naig_slotmap::_CMPSLT_ALTERNATIVES_
    {
      let label1 = format!("__{}_catch_{}", state.currentrule, state.counter);
      let label2 = format!("__{}_out_{}", state.currentrule, state.counter + 1);
      state.counter += 2;
      state.append_string(format!("  catch {}\n", label1));
      NaigCompiler::terms(child.first_child(), state)?;
      state.append_string(format!("  commit {}\n", label2));
      state.append_string(format!("{}:\n", label1));
      NaigCompiler::expression(child.last_child(), state)?;
      state.append_string(format!("{}:\n", label2));
      return Ok(());
    }
    else if child.slot == crate::naig_slotmap::_CMPSLT_TERMS_
    {
      NaigCompiler::terms(child, state)
    }
    else if child.slot == crate::naig_slotmap::_CMPSLT_TERM_
    {
      NaigCompiler::term(child, state)
    }
    else
    {
      tree.debug();
      panic!("Token error {}.", child.slot);
    }
  }

  fn terms
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    for i in 0 .. tree.children.len()
    {
      if tree.children[ i ].slot == crate::naig_slotmap::_CMPSLT_TERM_
      {
        NaigCompiler::term(& tree.children[ i ], state)?;
      }
    }
    return Ok(());
  }

  fn term
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let child = tree.first_child();
    if child.slot == crate::naig_slotmap::_CMPSLT_SCANMATCHER_
    {
      NaigCompiler::term_scanmatcher(child, state)
    }
    else if child.last_child().slot == crate::naig_slotmap::_CMPSLT_QUANTIFIER_
    {
      NaigCompiler::term_quantified(child, state)
    }
    else
    {
      NaigCompiler::matcher(child.first_child(), state)
    }
  }

  fn term_scanmatcher
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let lab = state.counter;
    let opr = tree.first_child().to_string();
    state.counter += 1;
    state.append_string(format!("  catch __scan_{}\n", lab));
    NaigCompiler::matcher(& tree.children[ 1 ], state)?;
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
    return Ok(());
  }

  fn quantifier_range
    (tree : & NaigCapTree)
    -> [ i32; 2 ]
  {
    if tree.to_string().eq("+")
    {
      return [ 1, -1 ];
    }
    else if tree.to_string().eq("*")
    {
      return [ 0, -1 ];
    }
    else if tree.to_string().eq("?")
    {
      return [ 0, 1 ];
    }
    else
    {
      if tree.first_child().children.len() == 2
      {
        return [
          tree.first_child().children[ 0 ].to_string().parse().unwrap(),
          tree.first_child().children[ 1 ].to_string().parse().unwrap(),
        ];
      }
      else
      {
        match tree.first_child().slot
        {
          crate::naig_slotmap::_CMPSLT_Q_UNTIL_ => [
            0,
            tree.first_child().children[ 0 ].to_string().parse().unwrap(),
          ],
          crate::naig_slotmap::_CMPSLT_Q_FROM_ => [
            tree.first_child().children[ 0 ].to_string().parse().unwrap(),
            -1,
          ],
          crate::naig_slotmap::_CMPSLT_Q_SPECIFIC_ => [
            tree.first_child().children[ 0 ].to_string().parse().unwrap(),
            tree.first_child().children[ 0 ].to_string().parse().unwrap(),
          ],
          _ => panic!("Token error"),
        }
      }
    }
  }

  fn term_quantified
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let qrange = NaigCompiler::quantifier_range(tree.last_child());

    match qrange[ 0 ]
    {
      0 => (),
      1 => NaigCompiler::matcher(tree.first_child(), state)?,
      _ => {
        let reg = state.reg;
        let cnt = state.counter;
        state.reg += 1;
        state.counter += 1;
        state.append_string(format!("  counter {} {}\n", reg, qrange[ 0 ]));
        state.append_string(format!("__loop_{}:\n", cnt));
        NaigCompiler::matcher(tree.first_child(), state)?;
        state.append_string(format!("  condjump {} __loop_{}\n", reg, cnt));
      },
    }

    if qrange[ 1 ] == -1
    {
      let fgv = state.counter; state.counter += 1;
      let cnt = state.counter; state.counter += 1;
      state.append_string(format!("  catch __forgive_{}\n", fgv));
      state.append_string(format!("__loop_{}:\n", cnt));
      NaigCompiler::matcher(tree.first_child(), state)?;
      state.append_string(format!("  partialcommit __loop_{}\n", cnt));
      state.append_string(format!("__forgive_{}:\n", fgv));
    }
    else
    {
      let diff = qrange[ 1 ] - qrange[ 0 ];
      if diff < 0
      {
        return Err(NaigError::compiler(format!("Range is negative ({})", diff)));
      }
      if diff > 0
      {
        let fgv = state.counter;
        state.counter += 1;
        state.append_string(format!("  catch __forgive_{}\n", fgv));
        if diff == 1
        {
          NaigCompiler::matcher(tree.first_child(), state)?;
        }
        else
        {
          let reg = state.reg;
          let cnt = state.counter;
          state.reg += 1;
          state.counter += 1;
          state.append_string(format!("  counter {} {}\n", reg, diff));
          state.append_string(format!("__loop_{}:\n", cnt));
          NaigCompiler::matcher(tree.first_child(), state)?;
          state.append               ("  partialcommit __NEXT__\n");
          state.append_string(format!("  condjump {} __loop_{}\n", reg, cnt));
        }
        state.append_string(format!("  commit __forgive_{}\n", fgv));
        state.append_string(format!("__forgive_{}:\n", fgv));
      }
    }
    return Ok(());
  }

  fn matcher
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let child = tree.first_child();
    match child.slot
    {
      crate::naig_slotmap::_CMPSLT_ANY_ => NaigCompiler::match_any(state),
      crate::naig_slotmap::_CMPSLT_SET_ => NaigCompiler::match_set(child, state),
      crate::naig_slotmap::_CMPSLT_STRING_ => NaigCompiler::match_string(child, state),
      crate::naig_slotmap::_CMPSLT_BITMASK_ => NaigCompiler::match_bitmask(child, state),
      crate::naig_slotmap::_CMPSLT_HEXLITERAL_ => NaigCompiler::match_hexliteral(child, state),
      crate::naig_slotmap::_CMPSLT_VARCAPTURE_ => NaigCompiler::match_varcapture(child, state),
      crate::naig_slotmap::_CMPSLT_CAPTURE_ => NaigCompiler::match_capture(child, state),
      crate::naig_slotmap::_CMPSLT_GROUP_ => NaigCompiler::match_group(child, state),
      crate::naig_slotmap::_CMPSLT_MACRO_ => NaigCompiler::match_macro(child, state),
      crate::naig_slotmap::_CMPSLT_VARREFERENCE_ => NaigCompiler::match_varreference(child, state),
      crate::naig_slotmap::_CMPSLT_REFERENCE_ => NaigCompiler::match_reference(child, state),
      _ => panic!("Parsing token in matcher"),
    }
  }

  fn match_any
    (state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    state.append("  any\n");
    return Ok(());
  }

  fn set_unescape
    (atom : & Vec<u8>)
    -> Result< usize, NaigError >
  {
    if atom.len() == 1
    {
      return Ok(atom[ 0 ] as usize);
    }
    else if atom[ 0 ] == '\\' as u8
    {
      match atom[ 1 ]
      {
        0x5c => return Ok(0x5c), // \\
        0x5d => return Ok(0x5d), // \]
        0x2d => return Ok(0x2d), // \-
        0x6e => return Ok(0x0a), // \n
        0x72 => return Ok(0x0d), // \r
        0x74 => return Ok(0x09), // \t
        0x76 => return Ok(0x0b), // \v
        _    => return Err(
                  NaigError::compiler(
                    format!(
                      "Unrecognized set escape '\\{}' ({:#04x})"
                     , atom[ 1 ] as char
                     , atom[ 1 ]
                ))),
      }
    }
    return Err(
             NaigError::compiler(
               format!(
                 "Unrecognized set sequence starting with '{}' ({:#04x})"
                 , atom[ 0 ] as char
                 , atom[ 0 ]
           )));
  }

  fn match_set
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let mut start = 0;
    let mut invert = false;
    let mut set = NaigCompilerSet::new();
    if tree.first_child().slot == crate::naig_slotmap::_CMPSLT_SETNOT_
    {
      invert = true;
      start = 1;
    }
    for i in start .. tree.children.len()
    {
      let child = & tree.children[ i ];
      if child.slot == crate::naig_slotmap::_CMPSLT_SET_NRTV
      {
        let from = NaigCompiler::set_unescape(& child.content)?;
        let until = NaigCompiler::set_unescape(& tree.children[ i+1 ].content)?;
        set.set_range(from, until);
      }
      else if child.slot == crate::naig_slotmap::_CMPSLT_SET_NRTV_2
      {
        let chr = NaigCompiler::set_unescape(& child.content)?;
        set.set(chr);
      }
    }
    if invert
    {
      set.invert();
    }
    state.append_string(format!("  set {}\n", set.to_string()));
    return Ok(());
  }

  fn match_string_ci
    (tree : & NaigCapTree, state : & mut NaigCompilerState, ci : bool)
    -> Result< (), NaigError >
  {
    let mut skip = false;
    let mut len = tree.content.len()-1;
    if ci
    {
      len -= 1;
    }
    for i in 1 .. len
    {
      if skip
      {
        skip = false;
        continue;
      }
      if tree.content[ i ] == '\\' as u8
      {
        match tree.content[ i+1 ]
        {
          0x6e => state.append("  char 0a\n"), // '\n'
          0x72 => state.append("  char 0d\n"), // '\r'
          0x74 => state.append("  char 09\n"), // '\t'
          0x76 => state.append("  char 0b\n"), // '\v'
          0x27 => state.append("  char 27\n"), // '\''
          0x5c => state.append("  char 5c\n"), // '\\'
          _    => { return Err(NaigError::compiler(format!("Unknown escape \\{}", tree.content[ i+1 ] as char))); }
        }
        skip = true;
      }
      else
      {
        if ci && tree.content[ i ] >= 65 && tree.content[ i ] <= 90 // A-Z
        {
          let mut set = NaigCompilerSet::new();
          set.set(tree.content[ i ] as usize);
          set.set(tree.content[ i ] as usize + 32);
          state.append_string(format!("  set {}\n", set.to_string()));
        }
        else if ci && tree.content[ i ] >= 97 && tree.content[ i ] <= 122 // a-z
        {
          let mut set = NaigCompilerSet::new();
          set.set(tree.content[ i ] as usize);
          set.set(tree.content[ i ] as usize - 32);
          state.append_string(format!("  set {}\n", set.to_string()));
        }
        else
        {
          state.append_string(format!("  char {:02x}\n", tree.content[ i ]));
        }
      }
    }
    return Ok(());
  }

  fn match_string
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    if tree.content[ tree.content.len()-1 ] == 'i' as u8
    {
      NaigCompiler::match_string_ci(tree, state, true)
    }
    else
    {
      NaigCompiler::match_string_ci(tree, state, false)
    }
  }

  fn match_bitmask
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let ins = tree.to_string();
    let hex = & ins[ 1..3 ];
    let msk = & ins[ 4..6 ];
    state.append_string(format!("  maskedchar {} {}\n", hex, msk));
    return Ok(());
  }

  fn match_hexliteral
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let ins = tree.to_string();
    let hex = & ins[ 2..4 ];
    state.append_string(format!("  char {}\n", hex));
    return Ok(());
  }

  fn match_varcapture
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let varname = tree.first_child().to_string();
    let slot = state.capture(tree);
    state.var_put(varname, slot);
    state.append_string(format!("  opencapture {}\n", slot));
    NaigCompiler::expression(& tree.children[ 1 ], state)?;
    state.append_string(format!("  closecapture {}\n", slot));
    return Ok(());
  }

  fn match_capture
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let slot = state.capture(tree);
    state.append_string(format!("  opencapture {}\n", slot));
    NaigCompiler::expression(tree.first_child(), state)?;
    state.append_string(format!("  closecapture {}\n", slot));
    return Ok(());
  }

  fn match_group
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    NaigCompiler::expression(tree.first_child(), state)
  }

  fn match_macro
    (tree : & NaigCapTree, state : & mut NaigCompilerState)
    -> Result< (), NaigError >
  {
    let mcroni = tree.to_string();
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
    else
    {
      return Err(NaigError::compiler(format!("Unknown macro '{}'", mcroni)));
    }
    state.append_string(format!("  set {}\n", set.to_string()));
    return Ok(());
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
    -> Result< (), NaigError >
  {
    state.append_string(format!("  call __RULE_{}\n", tree.to_string()));
    return Ok(());
  }
}
