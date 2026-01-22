# Chapter 6: Primjeri poruka (Message Examples)

**Source:** Pages 115-207 of Technical Specification v2.6 (Chapter 9)

---

## Overview

Chapter 9 provides complete XML message examples for all fiscalization services. These examples are **production-ready templates** that can be adapted for implementation.

---

## Complete Message Examples

> **All XML examples below are extracted from the official specification (Chapter 9, pages 115-207, examples 9.1-9.57). Each file is transcribed exactly as it appears in the PDF.**

### Example Files Overview

| Example # | Type | Description | Files |
|-----------|------|-------------|-------|
| 9.1-9.6 | Račun (Invoice) | Invoice fiscalization and error responses | [racun-izvorni-oblik-91-zahtjev.xml](../code-examples/racun-izvorni-oblik-91-zahtjev.xml) - [racun-greska-s-elektronickim-potpisom-96-odgovor.xml](../code-examples/racun-greska-s-elektronickim-potpisom-96-odgovor.xml) |
| 9.7-9.14 | Promjena načina plaćanja (Payment method change) | Payment change requests and responses | [promjena-nacina-placanja-izvorni-oblik-97-zahtjev.xml](../code-examples/promjena-nacina-placanja-izvorni-oblik-97-zahtjev.xml) - [promjena-nacina-placanja-s-elektronickim-potpisom-914-odgovor.xml](../code-examples/promjena-nacina-placanja-s-elektronickim-potpisom-914-odgovor.xml) |
| 9.15-9.20 | Prodaja samoposlužnih uređaja (Self-service) | Self-service device sales | [prodaja-samoposluzni-s-elektronickim-potpisom-915-zahtjev.xml](../code-examples/prodaja-samoposluzni-s-elektronickim-potpisom-915-zahtjev.xml) - [prodaja-samoposluzni-s-elektronickim-potpisom-920-odgovor.xml](../code-examples/prodaja-samoposluzni-s-elektronickim-potpisom-920-odgovor.xml) |
| 9.21-9.28 | Napojnica (Tip) | Tip/gratuity fiscalization | [napojnica-s-elektronickim-potpisom-921-zahtjev.xml](../code-examples/napojnica-s-elektronickim-potpisom-921-zahtjev.xml) - [napojnica-s-elektronickim-potpisom-928-odgovor.xml](../code-examples/napojnica-s-elektronickim-potpisom-928-odgovor.xml) |
| 9.29-9.30 | Echo metoda | Echo method test | [echo-metoda-929-zahtjev.xml](../code-examples/echo-metoda-929-zahtjev.xml) - [echo-metoda-930-odgovor.xml](../code-examples/echo-metoda-930-odgovor.xml) |
| 9.31-9.34 | Provjera računa (Invoice check) | Invoice verification | [racun-izvorni-oblik-931-zahtjev.xml](../code-examples/racun-izvorni-oblik-931-zahtjev.xml) - [racun-s-elektronickim-potpisom-934-odgovor.xml](../code-examples/racun-s-elektronickim-potpisom-934-odgovor.xml) |
| 9.35-9.37 | Račun s OIB-om primatelja (Invoice with recipient OIB) | Invoice with recipient data | [racun-s-oib-om-primatelja-935-zahtjev.xml](../code-examples/racun-s-oib-om-primatelja-935-zahtjev.xml) - [racun-s-oib-om-primatelja-937-odgovor.xml](../code-examples/racun-s-oib-om-primatelja-937-odgovor.xml) |
| 9.38-9.41 | Promjena podataka računa (Change invoice data) | Invoice data modification | [racun-938-zahtjev.xml](../code-examples/racun-938-zahtjev.xml) - [racun-941-odgovor.xml](../code-examples/racun-941-odgovor.xml) |
| 9.42-9.45 | Dohvat radnog vremena (Get working hours) | Retrieve working hours data | [dohvat-radnog-vremena-s-elektronickim-potpisom-942-zahtjev.xml](../code-examples/dohvat-radnog-vremena-s-elektronickim-potpisom-942-zahtjev.xml) - [dohvat-radnog-vremena-s-elektronickim-potpisom-945-odgovor.xml](../code-examples/dohvat-radnog-vremena-s-elektronickim-potpisom-945-odgovor.xml) |
| 9.46-9.49 | Brisanje radnog vremena (Delete working hours) | Delete working hours data | [brisanje-radnog-vremena-s-elektronickim-potpisom-946-zahtjev.xml](../code-examples/brisanje-radnog-vremena-s-elektronickim-potpisom-946-zahtjev.xml) - [brisanje-radnog-vremena-s-elektronickim-potpisom-949-odgovor.xml](../code-examples/brisanje-radnog-vremena-s-elektronickim-potpisom-949-odgovor.xml) |
| 9.50-9.53 | Prijava radnog vremena (Report working hours) | Report working hours data | [prijava-radnog-vremena-s-elektronickim-potpisom-950-zahtjev.xml](../code-examples/prijava-radnog-vremena-s-elektronickim-potpisom-950-zahtjev.xml) - [prijava-radnog-vremena-s-elektronickim-potpisom-953-odgovor.xml](../code-examples/prijava-radnog-vremena-s-elektronickim-potpisom-953-odgovor.xml) |
| 9.54-9.57 | Prijava radnih vremena liste poslovnih (Report for list) | Report working hours for business location list | [prijava-radnih-vremena-liste-poslovnih-s-elektronickim-potpisom-954-zahtjev.xml](../code-examples/prijava-radnih-vremena-liste-poslovnih-s-elektronickim-potpisom-954-zahtjev.xml) - [prijava-radnih-vremena-liste-poslovnih-s-elektronickim-potpisom-957-odgovor.xml](../code-examples/prijava-radnih-vremena-liste-poslovnih-s-elektronickim-potpisom-957-odgovor.xml) |

### Working with Examples

Each example file contains:
- Complete SOAP envelope structure
- Proper XML namespace declarations
- Request/Response body with schema-compliant elements
- Digital signature (Signature element) where applicable
- Example data (test OIBs, timestamps, values)

**Element naming in examples:**
- Requests end with `Zahtjev` (e.g., `RacunZahtjev`, `PromijeniNacPlacZahtjev`)
- Responses end with `Odgovor` (e.g., `RacunOdgovor`, `PromijeniNacPlacOdgovor`)
- Error responses contain `<Greske>` element with error details

**Example request structure:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="http://www.apis-it.hr/fin/2012/types/f73">
  <soapenv:Header/>
  <soapenv:Body>
    <tns:RacunZahtjev Id="racunId">
      <tns:Zaglavlje>
        <tns:IdPoruke>uuid-here</tns:IdPoruke>
        <tns:DatumVrijeme>2025-12-08T10:00:00</tns:DatumVrijeme>
      </tns:Zaglavlje>
      <tns:Racun>
        <!-- Invoice data -->
      </tns:Racun>
      <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
        <!-- Signature content -->
      </Signature>
    </tns:RacunZahtjev>
  </soapenv:Body>
</soapenv:Envelope>
```

**Example response structure:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="http://www.apis-it.hr/fin/2012/types/f73">
  <soapenv:Header/>
  <soapenv:Body>
    <tns:RacunOdgovor Id="responseId">
      <tns:Zaglavlje>
        <tns:IdPoruke>uuid-here</tns:IdPoruke>
        <tns:DatumVrijeme>2025-12-08T10:00:05</tns:DatumVrijeme>
      </tns:Zaglavlje>
      <tns:Jir>jir-uuid-here</tns:Jir>
      <tns:ZastKod>zki-code-here</tns:ZastKod>
      <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
        <!-- Response signature -->
      </Signature>
    </tns:RacunOdgovor>
  </soapenv:Body>
</soapenv:Envelope>
```

**Error response structure:**
```xml
<tns:RacunOdgovor Id="errorId">
  <tns:Zaglavlje>
    <tns:IdPoruke>uuid-here</tns:IdPoruke>
    <tns:DatumVrijeme>2025-12-08T10:00:05</tns:DatumVrijeme>
  </tns:Zaglavlje>
  <tns:Greske>
    <tns:Greska>
      <tns:SifraGreske>13</tns:SifraGreske>
      <tns:PorukaGreske>Error description here</tns:PorukaGreske>
    </tns:Greska>
  </tns:Greske>
  <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
    <!-- Error response signature -->
  </Signature>
</tns:RacunOdgovor>
```

---

## Implementation Guidelines

These examples are reference templates from the official specification. When implementing:

1. **Adapt to your language:** Convert XML structure to your programming language's objects
2. **Use schema validation:** Validate generated XML against FiskalizacijaSchema.xsd
3. **Test with test environment:** Use CIS test URL before production
4. **Handle errors:** Implement proper error handling for all CIS error codes
5. **Log requests:** Save request/response XML for troubleshooting

**Schema Validation Tools:**
- Command line: `xmllint --schema FiskalizacijaSchema.xsd request.xml`
- Online: https://www.freeformatter.com/xml-validator-xsd.html
- Programming: Use your language's XML schema validation

---

## Related Documentation

- [Chapter 5: Services Overview](05-services-overview.md)
- [Services 5.1-5.6: Detailed](06-11-services-detailed.md)
- [Code Examples](../code-examples/)

---

*Note: All examples in this chapter are from the official specification and should be used as reference templates for implementation.*
