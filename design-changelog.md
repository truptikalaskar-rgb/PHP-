# Design Changelog — Provider Mobile App (CRYSTAL)

Format matches the timesheet: `Date | Billable | Description | Hours`

---

## 29/9/2026 — Yes — 8 hrs

**CRYSTAL**

**Provider Mobile App — Orders (new full-page forms)**
- Designed Provider Mobile App > Patient > Orders > Add Lab Order screen
- Designed Provider Mobile App > Patient > Orders > Add Referral screen
- Designed Provider Mobile App > Patient > Orders > Add Referral — Imaging variant
- Added Save as Draft / Save and Print / Save action row to Add Lab Order
- Added Cancel / Print And Save / Save action row to Add Referral
- Added patient summary header card to Add Referral (name, DOB, age, sex, referring provider)

**Form component set (web parity)**
- Added reusable labelled field, dropdown-field, textarea, date-picker and checkbox components
- Added 9 order-form dropdown option sets (Lab Center, Lab, Payer, Tests, ICD Codes, Provider, Referral Type, Imaging Center, Diagnosis Codes)
- Added clearable Order Date field defaulting to current date
- Added POC Hold, Attach Insurance Details, Attach Provider Signature and Mark as STAT checkboxes

**Orders flow wiring**
- Reworked Orders > "+ Add" routing — Lab Order, Imaging and Referral now open their own full-page forms instead of placing a stub order
- Added required-field validation with inline toast messaging on both forms
- Saved orders now push into the Orders list and land on Order Details

**Patient Chart > Labs — Orders / Results tabs**
- Split the Labs tab's stacked "Lab Orders" and "Lab Results" sections into their own Orders / Results tabs
- Applied the same Orders / Results split to the Imaging tab (Reports stays a single list)
- Added inline count badges to the new tabs, replacing the old section-header counts

**Patient Chart > Labs — single tab row + real report contents**
- Merged the two tab rows into one: Orders / Results / Reports (Labs and Imaging no longer split the row)
- Orders and Results now span both labs and imaging, sorted newest first; each row carries its own modality icon and order type
- Authored per-document contents for all 10 reports — analyte tables with reference ranges and High/Low flags for the four lab panels, narrative Findings/Impression reports for the three imaging studies and three clinical documents
- Document Viewer now renders the report that was tapped instead of one hardcoded lipid/CBC page, with an out-of-range summary badge and a real page count
