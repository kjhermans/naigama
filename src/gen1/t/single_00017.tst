-- Grammar:

CHECK       <- UTF8CHECK XMLCHECK

UTF8CHECK   <- & UTF8TEXT

UTF8TEXT    <- UTF8CHAR* !.
UTF8CHAR    <- ASCII / DOUBLE / TRIPLE / QUADRUPLE
ASCII       <- [\000-\177]
DOUBLE      <- [\300-\337] [\200-\277]
TRIPLE      <- [\340-\357] [\200-\277] [\200-\277]
QUADRUPLE   <- [\360-\367] [\200-\277] [\200-\277] [\200-\277]

__prefix    <- %s*

XMLCHECK    <- optheader complexitem END
END         <- !.

optheader   <- header?
header      <- '<?xml' optattrs '?>'

item        <- complexitem / simpleitem
simpleitem  <- '<' { XMLIDENT } optattrs %s* '/>'
complexitem <- '<' {:tag: XMLIDENT } optattrs %s* '>'
               complexbody %s*
               '</' $tag '>'
complexbody <- (item / cdata / { (!(%s* '<') .)+ })*
cdata       <- '<![CDATA[' { ( !']]>' .)* } ']]>'
optattrs    <- ( ( attrname1 / attrname2 ) EQUALS attrvalue )*
attrname1   <- {:nbrace: ['"] } { XMLIDENT } $nbrace
attrname2   <- { XMLIDENT }
attrvalue   <- {:vbrace: ['"] } { ( ! $vbrace . )* } $vbrace
EQUALS      <- '='
XMLIDENT    <- [a-zA-Z][a-zA-Z0-9:]*

-- Input:

<s1:JDSSIEMProtocolMessage xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:s0="urn:int:nato:standard:LCG1" xmlns:s1="urn:int:nato:standard:LCG1:JDSSIEM:1.1" xmlns:s2="urn:int:nato:standard:mip:jc3iedm:3.0.2:oo:2.2" xmlns:s3="urn:int:nato:standard:mip:jdssdm:1.1">
  <s1:SourceGateway>
    <s1:GatewayID>b51d062e-6ef2-4310-8d3e-8af80828339f</s1:GatewayID>
    <s1:SessionID>56</s1:SessionID>
  </s1:SourceGateway>
  <s1:PayloadMessage>
    <s1:SyncableMessageInfo>
      <s1:SyncSetNumber>1</s1:SyncSetNumber>
      <s1:SyncPointNumber>0</s1:SyncPointNumber>
      <s1:TrailingEdgeSPN>0</s1:TrailingEdgeSPN>
      <s1:FullSyncSupported>false</s1:FullSyncSupported>
    </s1:SyncableMessageInfo>
    <s1:Payload xmlns:p0="urn:int:nato:standard:mip:jdssdm:1.1" xsi:type="p0:JDSSDMMessageType">
      <p0:Id>5caebe1f-2f7a-44b7-80e1-1b0e5280accb</p0:Id>
      <p0:Datetime>20180322070445.694</p0:Datetime>
      <p0:Originator>4615b519-45f6-4c4e-b73b-5f70303cf0c0</p0:Originator>
      <p0:OriginatorCountryCode>NLD</p0:OriginatorCountryCode>
      <p0:GenInfoMsg ReportingDatetime="20180322070445.694">
        <p0:TextItem>
          <p0:OID>bbba4e47-88e0-4ed3-b17d-14a4dc8ab1ec</p0:OID>
          <p0:MessageSubject>blue_force</p0:MessageSubject>
          <p0:MessageBody>AAAAUwEBAQEBAQEBAQEBAQEBAQECAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgoKYmx1ZV9mb3JjZRILMTkyLjE2OC4xLjE=</p0:MessageBody>
        </p0:TextItem>
      </p0:GenInfoMsg>
    </s1:Payload>
  </s1:PayloadMessage>
</s1:JDSSIEMProtocolMessage>

-- Result:

OK
