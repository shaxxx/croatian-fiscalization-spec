# Chapter 5: Servisi (Services) - Overview

**Source:** Pages 55-133 of Technical Specification v2.6

---

## Available Services

CIS provides the following fiscalization services:

| # | Service | Description | Page |
|---|---------|-------------|------|
| 5.1 | Poslovni prostor | Business space registration/update | 55-65 |
| 5.2 | Fiskalizacija računa | Invoice fiscalization | 66-71 |
| 5.3 | Promjena načina plaćanja | Payment method change | 72-81 |
| 5.4 | Fiskalizacija ISSN broj | ISSN fiscalization | 82-90 |
| 5.5 | Izvješće o izdanom računu | Invoice report (PD/PO) | 91-114 |
| 5.6 | Provjera radnog vremena | Working hours verification | 115-133 |

---

## Common Service Structure

> **Note:** The examples below use `FiskalizacijaRequest` and `FiskalizacijaResponse` as **abstract placeholders** to illustrate the common structure shared by all services. Actual XML uses specific element names such as `RacunZahtjev`, `PromijeniNacPlacZahtjev`, `RacunOdgovor`, etc.

### Request Format

All services follow this request structure:

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <!-- Abstract: In actual XML, this is RacunZahtjev, PromijeniNacPlacZahtjev, etc. -->
    <FiskalizacijaRequest xmlns="http://www.apis-it.hr/fin/2012/types/f73">
      <Zaglavlje>
        <IdPoslovnogProstora>...</IdPoslovnogProstora>
        <Oib>...</Oib>
        <DatumVrijeme>...</DatumVrijeme>
      </Zaglavlje>

      <!-- Service-specific body -->
      <PoslovniProstor>...</PoslovniProstor>
      <!-- OR -->
      <Racun>...</Racun>
      <!-- OR -->
      <PromjenaNacinaPlacanja>...</PromjenaNacinaPlacanja>
      <!-- etc. -->

      <SignatureXml>
        <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
          <!-- Signature content -->
        </Signature>
      </SignatureXml>
    </FiskalizacijaRequest>
  </soap:Body>
</soap:Envelope>
```

### Response Format

All services follow this response structure:

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <!-- Abstract: In actual XML, this is RacunOdgovor, PromijeniNacPlacOdgovor, etc. -->
    <FiskalizacijaResponse xmlns="http://www.apis-it.hr/fin/2012/types/f73">
      <Zaglavlje>
        <IdPoslovnogProstora>...</IdPoslovnogProstora>
        <Oib>...</Oib>
        <DatumVrijeme>...</DatumVrijeme>
      </Zaglavlje>

      <!-- Service-specific response -->
      <JIR>...</JIR>
      <!-- OR -->
      <Status>...</Status>
      <!-- etc. -->

      <SignatureXml>
        <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
          <!-- Response signature -->
        </Signature>
      </SignatureXml>
    </FiskalizacijaResponse>
  </soap:Body>
</soap:Envelope>
```

### Error Response

```xml
<!-- Abstract placeholder - actual response types vary by service -->
<FiskalizacijaResponse>
  <Zaglavlje>...</Zaglavlje>
  <Greske>
    <Greska>
      <SifraGreske>13</SifraGreske>
      <PorukaGreske>Opis greške</PorukaGreske>
    </Greska>
  </Greske>
</FiskalizacijaResponse>
```

---

## Service Endpoints

### Production Environment
```
URL: https://cis.porezna-uprava.hr:8449/FiskalizacijaService
Action: http://www.apis-it.hr/fin/2012/types/f73/FiskalizacijaService/{Operation}
```

### Test Environment
```
URL: https://cistest.apis-it.hr:8449/FiskalizacijaServiceTest
Action: http://www.apis-it.hr/fin/2012/types/f73/FiskalizacijaServiceTest/{Operation}
```

### SOAP Actions

| Service | Operation | SOAP Action |
|---------|-----------|-------------|
| Business Space | PoslovniProstor | `PoslovniProstor` |
| Invoice Fiscalization | Racun | `FiskalizacijaRacuna` |
| Payment Change | PromjenaNacinaPlacanja | `PromjenaNacinaPlacanja` |
| ISSN | RacunISSN | `FiskalizacijaISSN` |
| Invoice Report | IzvjesceOIzdanomRacunu | `IzvjesceOIzdanomRacunu` |
| Working Hours | RadnoVrijeme | `RadnoVrijeme` |

---

## Common Header Elements

### Zaglavlje (Header)

Required in every request and response:

| Element | Type | Required | Description |
|---------|------|----------|-------------|
| `IdPoslovnogProstora` | string | Yes | Business space identifier |
| `Oib` | string (11 chars) | Yes | Taxpayer's OIB |
| `DatumVrijeme` | dateTime | Yes | ISO 8601 with timezone |

**Example:**
```xml
<Zaglavlje>
  <IdPoslovnogProstora>123</IdPoslovnogProstora>
  <Oib>12345678901</Oib>
  <DatumVrijeme>2025-12-08T10:00:00+01:00</DatumVrijeme>
</Zaglavlje>
```

---

## Common Error Codes

| Code | Description | Common Causes |
|------|-------------|---------------|
| 13 | Validation error | Invalid data format, missing required fields |
| 14 | Signature error | Invalid signature, certificate issues |
| 15 | Time synchronization error | Time difference > 2 seconds |
| 176 | Invalid OIB | Wrong format, OIB doesn't match certificate |
| 177 | Invalid datetime | Wrong format, timezone missing |
| 178 | Time difference exceeded | System time not synchronized |
| 179 | Missing required field | Required element not provided |
| 180 | Invalid invoice number | Wrong format, duplicate |
| 181 | Invalid amount | Negative amount, wrong decimal places |
| 182 | Invalid tax rate | Rate not allowed, wrong format |
| 183 | Invalid business space | Business space not registered |
| 184 | Invalid certificate | Certificate expired, revoked, wrong OIB |

---

## Time Requirements

⚠️ **CRITICAL:** All services require accurate time synchronization!

### Requirements:
- **Maximum time difference:** ±2 seconds from CIS time
- **Timezone:** CET (UTC+1) or CEST (UTC+2)
- **Format:** ISO 8601 with timezone offset: `YYYY-MM-DDTHH:MM:SS±HH:MM`
- **NTP sync:** Required for all systems

### Time Format Examples:
```
2025-12-08T10:00:00+01:00  (Winter time - CET)
2025-07-15T14:30:00+02:00  (Summer time - CEST)
```

---

## Rate Limiting

| Service | Max Requests | Time Window |
|---------|--------------|-------------|
| All services | No official limit | None |
| Best practice | < 10 req/sec | Sustained |
| Burst | < 50 req/sec | Short-term |

**Note:** While there's no official rate limit, excessive requests may trigger rate limiting or temporary blocking.

---

## Idempotency

Some operations are idempotent (safe to retry):

| Service | Idempotent | Notes |
|---------|------------|-------|
| Business Space Registration | No | Duplicate requests return error |
| Invoice Fiscalization | No | Same invoice generates error 183 |
| Payment Change | Yes | Can retry if no response |
| ISSN Fiscalization | No | Same ISSN generates error |
| Invoice Report | Yes | Can retry safely |
| Working Hours Report | Yes | Can retry safely |

---

## Async vs Sync

### Synchronous Operations (Recommended)
- Invoice Fiscalization
- Payment Change
- ISSN Fiscalization

**Use when:** Immediate confirmation required

### Asynchronous Operations
- Working Hours (bulk operations)
- Invoice Reports (batch)

**Use when:** Processing multiple items

---

## Service Documentation Links

Each service has detailed documentation:

1. [5.1 Poslovni prostor](06-service-business-space.md) - Business space management
2. [5.2 Fiskalizacija računa](07-service-invoice-fiscalization.md) - Invoice fiscalization
3. [5.3 Promjena načina plaćanja](08-service-payment-change.md) - Payment method changes
4. [5.4 Fiskalizacija ISSN broj](09-service-issn-fiscalization.md) - ISSN fiscalization
5. [5.5 Izvješće o izdanom računu](10-service-invoice-report.md) - Invoice reports
6. [5.6 Provjera radnog vremena](11-service-working-hours.md) - Working hours

---

## Implementation Guidelines

### 1. Request Preparation
1. Create request XML with service-specific body
2. Add header (IdPoslovnogProstora, Oib, DatumVrijeme)
3. Sign the request with digital certificate
4. Wrap in SOAP envelope

### 2. Sending Request
1. Establish HTTPS connection to CIS
2. Send SOAP request
3. Wait for response (with timeout)

### 3. Response Handling
1. Check for SOAP faults
2. Check for Greske (errors) element
3. Extract JIR or status on success
4. Validate response signature

### 4. Error Handling
1. Parse error code and message
2. Implement retry logic for transient errors
3. Log all errors for troubleshooting
4. Notify user of non-retryable errors

---

## Testing

### Test Environment Setup

```csharp
var fis = new Fiskalizacija
{
    Oib = "12345678901",
    Certifikat = testCertificate,
    CisUrl = "https://cistest.apis-it.hr:8449/FiskalizacijaServiceTest"
};
```

### Test Cases

1. **Positive tests:**
   - Valid request → Success response
   - All required fields provided → Success

2. **Negative tests:**
   - Invalid OIB → Error 176
   - Wrong time → Error 178
   - Invalid signature → Error 14
   - Missing field → Error 179

3. **Edge cases:**
   - Maximum length values
   - Special characters in text fields
   - Boundary amounts (0.01, 9999999.99)
   - Time zone transitions

---

## Implementation Notes

Implementation of these services requires:

1. **XML Generation:** Create request XML according to schemas
2. **Digital Signature:** Sign XML with X.509 certificate
3. **SOAP Communication:** Send via HTTPS to CIS endpoints
4. **Response Parsing:** Process CIS response and extract data

Common implementation approaches:
- **Use WSDL/XSD:** Generate client classes from schema
- **Manual XML:** Build XML strings manually
- **XML Libraries:** Use language XML libraries
- **SOAP Libraries:** Use language SOAP frameworks

Choose approach based on your programming language and requirements.

---

*See individual service documentation for details:*
- [Service 5.1: Business Space](06-service-business-space.md)
- [Service 5.2: Invoice Fiscalization](07-service-invoice-fiscalization.md)
- [Service 5.3: Payment Change](08-service-payment-change.md)
- [Service 5.4: ISSN](09-service-issn-fiscalization.md)
- [Service 5.5: Invoice Report](10-service-invoice-report.md)
- [Service 5.6: Working Hours](11-service-working-hours.md)
