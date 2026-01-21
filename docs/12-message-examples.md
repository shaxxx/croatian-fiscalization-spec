# Chapter 6: Primjeri poruka (Message Examples)

**Source:** Pages 134-177 of Technical Specification v2.6

---

## Overview

Chapter 6 provides complete XML message examples for all fiscalization services. These examples are **production-ready templates** that can be adapted for implementation.

---

## Complete Message Examples

### 1. Business Space Registration (Poslovni prostor)

#### Request
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaRequest xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:00:00+01:00</DatumVrijeme>
      </Zaglavlje>

      <PoslovniProstor>
        <Oib>12345678901</Oib>
        <Naziv>Primjer d.o.o.</Naziv>
        <Adresa>
          <Ulica>Ilica 1</Ulica>
          <KucniBroj>10</KucniBroj>
          <KucniBrojDodatak></KucniBrojDodatak>
          <BrojPoste>10000</BrojPoste>
          <Naselje>Zagreb</Naselje>
          <Opcina></Opcina>
        </Adresa>

        <PoslovniProstor>
          <OznakaPoslovnogProstora>1</OznakaPoslovnogProstora>
          <VrstaPoslovnogProstova>Prodajno mjesto</VrstaPoslovnogProstora>
        </PoslovniProstor>

        <DatumPocetkaPrimjene>2025-01-01</DatumPocetkaPrimjene>
      </PoslovniProstor>

      <SignatureXml>
        <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
          <SignedInfo>
            <CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
            <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha256"/>
            <Reference URI="">
              <Transforms>
                <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
                <Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
              </Transforms>
              <DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
              <DigestValue>BASE64_DIGEST</DigestValue>
            </Reference>
          </SignedInfo>
          <SignatureValue>BASE64_SIGNATURE</SignatureValue>
          <KeyInfo>
            <X509Data>
              <X509Certificate>BASE64_CERT</X509Certificate>
            </X509Data>
          </KeyInfo>
        </Signature>
      </SignatureXml>
    </FiskalizacijaRequest>
  </soap:Body>
</soap:Envelope>
```

#### Response
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaResponse xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:00:05+01:00</DatumVrijeme>
      </Zaglavlje>
      <Status>OK</Status>
      <SignatureXml>
        <!-- Response signature -->
      </SignatureXml>
    </FiskalizacijaResponse>
  </soap:Body>
</soap:Envelope>
```

---

### 2. Invoice Fiscalization (Fiskalizacija računa)

#### Request
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaRequest xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:05:00+01:00</DatumVrijeme>
      </Zaglavlje>

      <Racun>
        <Oib>12345678901</Oib>
        <OznakaSlijeda>P</OznakaSlijeda>
        <BrojOznakaSlijeda>1</BrojOznakaSlijeda>
        <BrRacuna>1/2025</BrRacuna>
        <DatumVrijeme>2025-12-08T10:00:00+01:00</DatumVrijeme>

        <NaciniPlacanja>
          <NacinPlacanja>
            <Naziv>G</Naziv>
            <Iznos>126.00</Iznos>
          </NacinPlacanja>
        </NaciniPlacanja>

        <IznosUkupno>126.00</IznosUkupno>

        <UkupnoPorez>
          <Porez>
            <Naziv>PDV</Naziv>
            <Stopa>25.00</Stopa>
            <Osnovica>100.80</Osnovica>
            <Iznos>25.20</Iznos>
          </Porez>
        </UkupnoPorez>
      </Racun>

      <SignatureXml>
        <!-- Signature -->
      </SignatureXml>
    </FiskalizacijaRequest>
  </soap:Body>
</soap:Envelope>
```

#### Response
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaResponse xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:05:02+01:00</DatumVrijeme>
      </Zaglavlje>
      <JIR>1234567890123456789012345678901234</JIR>
      <SignatureXml>
        <!-- Response signature -->
      </SignatureXml>
    </FiskalizacijaResponse>
  </soap:Body>
</soap:Envelope>
```

---

### 3. Payment Method Change (Promjena načina plaćanja)

#### Request
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaRequest xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:10:00+01:00</DatumVrijeme>
      </Zaglavlje>

      <PromjenaNacinaPlacanja>
        <Oib>12345678901</Oib>
        <OznakaSlijeda>P</OznakaSlijeda>
        <BrojOznakaSlijeda>1</BrojOznakaSlijeda>
        <BrRacuna>1/2025</BrRacuna>
        <DatumVrijeme>2025-12-08T10:00:00+01:00</DatumVrijeme>
        <IznosUkupno>126.00</IznosUkupno>

        <NaciniPlacanja>
          <NacinPlacanja>
            <Naziv>K</Naziv>
            <Iznos>126.00</Iznos>
          </NacinPlacanja>
        </NaciniPlacanja>
      </PromjenaNacinaPlacanja>

      <SignatureXml>
        <!-- Signature -->
      </SignatureXml>
    </FiskalizacijaRequest>
  </soap:Body>
</soap:Envelope>
```

#### Response
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaResponse xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:10:02+01:00</DatumVrijeme>
      </Zaglavlje>
      <Status>OK</Status>
      <SignatureXml>
        <!-- Response signature -->
      </SignatureXml>
    </FiskalizacijaResponse>
  </soap:Body>
</soap:Envelope>
```

---

### 4. ISSN Fiscalization

#### Request
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaRequest xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:15:00+01:00</DatumVrijeme>
      </Zaglavlje>

      <Racun>
        <Oib>12345678901</Oib>
        <OznakaSlijeda>P</OznakaSlijeda>
        <BrojOznakaSlijeda>1</BrojOznakaSlijeda>
        <BrRacuna>ISSN-1/2025</BrRacuna>
        <DatumVrijeme>2025-12-08T10:00:00+01:00</DatumVrijeme>

        <NaciniPlacanja>
          <NacinPlacanja>
            <Naziv>G</Naziv>
            <Iznos>100.00</Iznos>
          </NacinPlacanja>
        </NaciniPlacanja>

        <IznosUkupno>100.00</IznosUkupno>

        <UkupnoPorez>
          <Porez>
            <Naziv>PDV</Naziv>
            <Stopa>25.00</Stopa>
            <Osnovica>80.00</Osnovica>
            <Iznos>20.00</Iznos>
          </Porez>
        </UkupnoPorez>

        <ISSN>123456789012345</ISSN>
      </Racun>

      <SignatureXml>
        <!-- Signature -->
      </SignatureXml>
    </FiskalizacijaRequest>
  </soap:Body>
</soap:Envelope>
```

#### Response
Returns JIR (same as regular invoice fiscalization)

---

### 5. Invoice Report (Izvješće o izdanom računu)

#### Request
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaRequest xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:20:00+01:00</DatumVrijeme>
      </Zaglavlje>

      <IzvjesceOIzdanomRacunu>
        <Oib>12345678901</Oib>
        <OznakaSlijeda>P</OznakaSlijeda>
        <BrojOznakaSlijeda>1</BrojOznakaSlijeda>
        <BrRacuna>1/2025</BrRacuna>
        <DatumVrijeme>2025-12-08T10:00:00+01:00</DatumVrijeme>
        <IznosUkupno>126.00</IznosUkupno>

        <TipIzvjesca>PO</TipIzvjesca>
        <DatumVrijemeIzdavanja>2025-12-08T10:00:00+01:00</DatumVrijemeIzdavanja>
        <OibPoslovneJedinice>12345678901</OibPoslovneJedinice>
        <NacinPlacanja>G</NacinPlacanja>
      </IzvjesceOIzdanomRacunu>

      <SignatureXml>
        <!-- Signature -->
      </SignatureXml>
    </FiskalizacijaRequest>
  </soap:Body>
</soap:Envelope>
```

#### Response
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaResponse xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:20:02+01:00</DatumVrijeme>
      </Zaglavlje>
      <Status>OK</Status>
      <SignatureXml>
        <!-- Response signature -->
      </SignatureXml>
    </FiskalizacijaResponse>
  </soap:Body>
</soap:Envelope>
```

---

### 6. Working Hours Report (Provjera radnog vremena)

#### Report Request
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaRequest xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T11:00:00+01:00</DatumVrijeme>
      </Zaglavlje>

      <PrijaviRadnoVrijemeZaPoslovniceParams>
        <Oib>12345678901</Oib>
        <DatumOd>2025-01-01</DatumOd>
        <DatumDo>2025-12-31</DatumDo>

        <RadnoVrijemePoslovnice>
          <OibPoslovnice>12345678901</OibPoslovnice>
          <OznakaPoslovnogProstora>1</OznakaPoslovnogProstora>

          <RadnoVrijeme>
            <Dan>Ponedjeljak</Dan>
            <PocetakRadnogVremena>08:00:00</PocetakRadnogVremena>
            <KrajRadnogVremena>16:00:00</KrajRadnogVremena>
          </RadnoVrijeme>

          <RadnoVrijeme>
            <Dan>Utorak</Dan>
            <PocetakRadnogVremena>08:00:00</PocetakRadnogVremena>
            <KrajRadnogVremena>16:00:00</KrajRadnogVremena>
          </RadnoVrijeme>

          <RadnoVrijeme>
            <Dan>Srijeda</Dan>
            <PocetakRadnogVremena>08:00:00</PocetakRadnogVremena>
            <KrajRadnogVremena>16:00:00</KrajRadnogVremena>
          </RadnoVrijeme>

          <RadnoVrijeme>
            <Dan>Cetvrtak</Dan>
            <PocetakRadnogVremena>08:00:00</PocetakRadnogVremena>
            <KrajRadnogVremena>16:00:00</KrajRadnogVremena>
          </RadnoVrijeme>

          <RadnoVrijeme>
            <Dan>Petak</Dan>
            <PocetakRadnogVremena>08:00:00</PocetakRadnogVremena>
            <KrajRadnogVremena>16:00:00</KrajRadnogVremena>
          </RadnoVrijeme>
        </RadnoVrijemePoslovnice>
      </PrijaviRadnoVrijemeZaPoslovniceParams>

      <SignatureXml>
        <!-- Signature -->
      </SignatureXml>
    </FiskalizacijaRequest>
  </soap:Body>
</soap:Envelope>
```

#### Query Request
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaRequest xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T11:05:00+01:00</DatumVrijeme>
      </Zaglavlje>

      <DohvatiRadnoVrijemeParams>
        <Oib>12345678901</Oib>
        <OibPoslovnice>12345678901</OibPoslovnice>
        <OznakaPoslovnogProstora>1</OznakaPoslovnogProstora>
        <Datum>2025-12-08</Datum>
      </DohvatiRadnoVrijemeParams>

      <SignatureXml>
        <!-- Signature -->
      </SignatureXml>
    </FiskalizacijaRequest>
  </soap:Body>
</soap:Envelope>
```

#### Response
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaResponse xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T11:05:02+01:00</DatumVrijeme>
      </Zaglavlje>

      <RadnoVrijemePoslovnice>
        <OibPoslovnice>12345678901</OibPoslovnice>
        <OznakaPoslovnogProstora>1</OznakaPoslovnogProstora>

        <RadnoVrijeme>
          <Dan>Ponedjeljak</Dan>
          <PocetakRadnogVremena>08:00:00</PocetakRadnogVremena>
          <KrajRadnogVremena>16:00:00</KrajRadnogVremena>
        </RadnoVrijeme>

        <RadnoVrijeme>
          <Dan>Utorak</Dan>
          <PocetakRadnogVremena>08:00:00</PocetakRadnogVremena>
          <KrajRadnogVremena>16:00:00</KrajRadnogVremena>
        </RadnoVrijeme>
      </RadnoVrijemePoslovnice>

      <SignatureXml>
        <!-- Response signature -->
      </SignatureXml>
    </FiskalizacijaResponse>
  </soap:Body>
</soap:Envelope>
```

---

## Error Response Examples

### Validation Error (Error 13)
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <FiskalizacijaResponse xmlns="http://fiskalizacija.porezna.uprava.hr/2013/schema">
      <Zaglavlje>
        <IdPoslovnogProstora>1</IdPoslovnogProstora>
        <Oib>12345678901</Oib>
        <DatumVrijeme>2025-12-08T10:05:02+01:00</DatumVrijeme>
      </Zaglavlje>

      <Greske>
        <Greska>
          <SifraGreske>13</SifraGreske>
          <PorukaGreske>Greška u validaciji podataka</PorukaGreske>
        </Greska>
      </Greske>

      <SignatureXml>
        <!-- Response signature -->
      </SignatureXml>
    </FiskalizacijaResponse>
  </soap:Body>
</soap:Envelope>
```

### Signature Error (Error 14)
```xml
<FiskalizacijaResponse>
  <Zaglavlje>...</Zaglavlje>
  <Greske>
    <Greska>
      <SifraGreske>14</SifraGreske>
      <PorukaGreske>Neispravan digitalni potpis</PorukaGreske>
    </Greska>
  </Greske>
</FiskalizacijaResponse>
```

### Time Synchronization Error (Error 178)
```xml
<FiskalizacijaResponse>
  <Zaglavlje>...</Zaglavlje>
  <Greske>
    <Greska>
      <SifraGreske>178</SifraGreske>
      <PorukaGreske>Vremenska razlika je veća od dozvoljene</PorukaGreske>
    </Greska>
  </Greske>
</FiskalizacijaResponse>
```

---

## SOAP Fault Examples

### Malformed XML
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <soap:Fault>
      <faultcode>soap:Client</faultcode>
      <faultstring>Malformed XML request</faultstring>
      <detail>
        <error>XML parsing error at line 15, column 8</error>
      </detail>
    </soap:Fault>
  </soap:Body>
</soap:Envelope>
```

### Invalid SOAP Action
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <soap:Fault>
      <faultcode>soap:Client</faultcode>
      <faultstring>Invalid SOAP action</faultstring>
      <detail>
        <error>SOAP action 'UnknownAction' not recognized</error>
      </detail>
    </soap:Fault>
  </soap:Body>
</soap:Envelope>
```

---

## Key Implementation Notes

### 1. Signature Element Placement
- SignatureXml MUST be the last element in FiskalizacijaRequest
- Signature is computed BEFORE adding to SOAP envelope
- SOAP envelope wrapping is the FINAL step

### 2. Time Format
- Always include timezone: `+01:00` or `+02:00`
- Use NTP sync to ensure accuracy
- Format: `YYYY-MM-DDTHH:MM:SS±HH:MM`

### 3. Namespace Handling
- Main namespace: `http://fiskalizacija.porezna.uprava.hr/2013/schema`
- Signature namespace: `http://www.w3.org/2000/09/xmldsig#`
- SOAP namespace: `http://schemas.xmlsoap.org/soap/envelope/`

### 4. Decimal Formatting
- Use decimal point: `100.50` (NOT comma)
- Two decimal places for amounts: `100.00`
- Tax rates: Two decimal places: `25.00`

### 5. Character Encoding
- Always specify: `<?xml version="1.0" encoding="utf-8"?>`
- Use UTF-8 for all special characters (Č, Ć, Ž, Š, Đ)

---

## Testing with Examples

### Using Test Environment
1. Replace OIB with test OIB
2. Use test certificate
3. Point to: `https://cistest.apis-it.hr:8449/FiskalizacijaServiceTest`
4. Verify response structure matches examples

### Validation Checklist
- [ ] All required fields present
- [ ] Correct XML namespaces
- [ ] Valid signature
- [ ] Correct time format
- [ ] OIB matches certificate
- [ ] Decimal formatting correct
- [ ] UTF-8 encoding used

---

## Implementation Notes

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
