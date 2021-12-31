-- Grammar:

item <- ({ %s* opentag (item / %s* { (!(%s* '<') .)+ }) %s* closetag })+
opentag <- '<' {:tag: %w+ } '>'
closetag <- '</' $tag '>'

-- Input:

<personinfo>
  <firstname>KJ</firstname>
  <lastname>Hermans</lastname>
  <address>Somewhere</address>
  <city>Sometown</city>
  <country>Someland</country>
</personinfo>

-- Result:

OK
