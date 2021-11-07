-- Grammar:

TOP       <- XMLCHECK
__prefix  <- %s*
XMLCHECK  <- complexitem END
END       <- !.

item        <-  complexitem / simpleitem
simpleitem  <- '<' { XMLIDENT } optattrs %s* '/>'
complexitem <- '<' {:tag: XMLIDENT } optattrs %s* '>'
               complexbody %s*
               '</' $tag '>'
complexbody <- (item / { (!(%s* '<') .)+ })*
optattrs    <- ( ( attrname1 / attrname2 ) EQUALS attrvalue )*
attrname1   <- {:nbrace: ['"] } { XMLIDENT } $nbrace
attrname2   <- { XMLIDENT }
attrvalue   <- {:vbrace: ['"] } { ( ! $vbrace . )* } $vbrace
EQUALS      <- '='
XMLIDENT    <- [a-zA-Z:]+

-- Input:

<JDSSDMMessage xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="urn:int:nato:standard:mip:jdssdm:1.1">
  <Id OIDType="UUID">e10f91a3-9a5f-47c7-b886-84217634e2dd</Id>
  <Datetime>20170201104309.000</Datetime>
  <Originator OIDType="UUID">186495f7-da29-6bf8-80df-3a22a492b378</Originator>
  <OriginatorCountryCode>GBR</OriginatorCountryCode>
  <PresenceMsg>
    <Unit>
      <OID OIDType="UUID">072b030b-a126-b2f4-b237-4f342be9ed44</OID>
      <GeographicPoint>
        <LatitudeCoordinate>52.20429</LatitudeCoordinate>
        <LongitudeCoordinate>-2.18666</LongitudeCoordinate>
      </GeographicPoint>
    </Unit>
    <Unit>
      <OID OIDType="UUID">186495f7-da29-6bf8-80df-3a22a492b378</OID>
      <GeographicPoint>
        <LatitudeCoordinate>51.20429</LatitudeCoordinate>
        <LongitudeCoordinate>-2.18666</LongitudeCoordinate>
      </GeographicPoint>
    </Unit>
    <Unit>
      <OID OIDType="UUID">e7a2760d-b8f3-e7e9-9fb0-92fa89818dbb</OID>
      <GeographicPoint>
        <LatitudeCoordinate>53.20429</LatitudeCoordinate>
        <LongitudeCoordinate>-2.18666</LongitudeCoordinate>
      </GeographicPoint>
    </Unit>
    <Materiel>
      <OID OIDType="UUID">d4192ea1-2c48-8cf7-b4c4-2ce3697177f1</OID>
      <GeographicPoint>
        <LatitudeCoordinate>51.20429</LatitudeCoordinate>
        <LongitudeCoordinate>-2.18666</LongitudeCoordinate>
      </GeographicPoint>
    </Materiel>
  </PresenceMsg>
</JDSSDMMessage>

-- Result:

OK
