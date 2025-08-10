---
title: Better Mobile Payments UK
---

## Mission Statement

We want in-person Account-to-Account (A2A) payments in the UK to be as quick and as easy as contactless payments.

The simple reality should be: **Scan. Confirm. Sorted.**

We should all be able to do this using the banking apps on our phones, where QR codes or even NFC can turn most UK payments into two steps:

 1. **Confirmation**: See exactly what you're paying for, how much, and to whom
 2. **Send Payment**: One button to complete it via the Faster Payments System (FPS)

No data entry. No passwords. No ambiguity or trust about the amount or destination. Just clear confirmation and instant payment using the infrastructure and devices we already have.

## What We're Proposing

The minimal standardisation point: the communication of payment details and verification of payment completion. This should be realised as a UK payment URL scheme, which could look like:

```
pay.uk://fps?to=12-34-56.123456789&amt=589.37&ref=INVOICEID
```

We want to focus on using what currently exists, instead of creating or adopting complex standards that could exacerbate regulatory capture:

 * **Apps:** Banking apps are on most of our phones
 * **Infrastructure:** Faster Payments System (already near-instant)
 * **Hardware:** QR codes and passive NFC (are everywhere)
 * **Security:** Biometric authentication (implemented pervasively)
 * **Interface:** Native URL scheme handling (like every other app)

What's missing is the URL format - it's not new technology, but a de facto agreement on how the existing pieces can work together in a way which doesn't involve thousands of pages of specifications and multi-year conformance timelines.

The [European Payments Council (EPC) Quick Response (QR)](https://www.europeanpaymentscouncil.eu/document-library/guidance-documents/quick-response-code-guidelines-enable-data-capture-initiation) scheme unfortunately wasn't widely adopted in Europe, but what we're proposing is to learn from this, and other schemes such as [UPI](https://www.npci.org.in/what-we-do/upi/product-overview) in India and [PIX](https://www.bcb.gov.br/en/financialstability/pix_en) in Brazil which have gained rapid and widespread adoption in their respective countries - then to adopt the smallest most flexible parts which take the least effort to provide the most benefit not just to stakeholders, but to every citizen.

### How it works:

 * Scan a QR code, or tap with NFC, at any merchant
 * Your phone asks to open your preferred banking app (or lets you choose which one)
 * You confirm the payment with Face ID/Touch ID (no passwords or form-filling)
 * The payment settles via the Faster Payments System
 * There are zero interchange fees via foreign networks
 * UK banking regulations apply end-to-end

This is then combined with a low-trust polling API to verify if a specific payment has been received to the account. Point of sale systems will poll your own bank endpoint, using a restricted token, to check if a payment has been made. For example:

```
GET /fps/verify?acct=<X>&amt=589.37&ref=INVOICEID&token=<Y>

Response: {
  "received": true,
  "timestamp": "2025-08-08T14:30:22Z",
  "reference": "INVOICEID",
  "amount": ["589.37", "GBP"]
}
```

The restricted token would only:

 * Work for one specific account
 * Verify if individual payments have been received
   * Never showing outgoing or other incoming payments
 * Confirm only the specific amount & reference combinations

## Building Between Open Banking's Gaps

The FCA-regulated payments industry has made tremendous progress in creating mobile-friendly payment interfaces, and Open Banking has successfully opened up financial data sharing. However, as with PCI-DSS and 3D Secure, Open Banking has evolved into a system where the barrier to entry has become prohibitively high for the simplest of use cases.

Meanwhile many modern API systems are designed for direct consumer interaction without intermediaries, and handle billions of requests per year directly from user devices over the open internet. However, Open Banking's current implementation requires both FCA authorization and Open Banking certification for basic payment verification and initiation - creating a system where innovators try to work around the design rather than with it.

The current Open Banking system comes with many overheads and complexities:

### For Banks:

 * Complex API implementations requiring extensive certification
 * 90-day re-authorization cycles that break merchant integrations
 * Overprivileged access models that expose more data than needed

### For Payment Providers:

 * Multi-step authentication flows that disrupts the payment UX
 * Complex backend integrations which are difficult to maintain
 * Third-party data exposure when simple verification would suffice

### For Merchants:

 * Difficulty verifying payment receipt without granting full access
 * Re-authorization requirements that break point-of-sale systems
 * Complex integrations for what should be simple payment confirmation

The proposed simplified polling API approach addresses these challenges by providing exactly what's needed - immediate payment verification - without the complexity of full Open Banking integration. This complements rather than replaces Open Banking, focusing specifically on the retail payment use cases where simplicity and reliability is paramount.

Our approach returns to the principle of direct consumer interaction - bank apps talking directly to their customers, with minimal intermediary complexity. The polling API provides exactly what merchants need (payment verification) without requiring the full Open Banking certification stack or multi-leg back and forth with costly licensing or service fees unless they provide a true value-add.


## The Contactless Problem

Modern payment terminals have created a concerning disconnect between what consumers agree to pay and what they actually pay. The simple phrase "tap here" has replaced the fundamental principle of informed consent that should underpin transactions and subsequently contract law. The problems with the current contactless design can be summarised as:

 * Amounts are displayed on small screens, sometimes facing away from the customer
 * Payment can happen before clear amount confirmation
 * "Tap to pay" encourages speed and implicit acceptance over verification
 * Customers are conditioned to complete transactions without seeing the terms

The fatal conceit is that contactless payments can be triggered without the cardholder's knowledge - viral videos show people being charged simply by having a payment terminal tapped against their pocket or bag. The technology that was meant to make payments more convenient has inadvertently created opportunities for unauthorized transactions. Payment systems should require deliberate authorization, not passive proximity.

And this isn't inconvenient - it's a consumer protection issue:

 * Overcharging often goes unnoticed until checking statements later
 * Unauthorized contactless payments can happen without awareness
 * The need for RFID-blocking wallets shows the system's fundamental security flaw
 * Informed consent - a basic principle of contract law in any transaction - is significantly impaired

Our approach restores transactional clarity:
Every payment requires explicit confirmation of the exact amount and recipient before any money moves. You can't accidentally authorize a payment by walking past a terminal or having someone tap your pocket, or even by "fat-fingering" the amount then not being shown the terminal screen.

# Let's Take a Step Forward

The UK stands at a unique inflection point. We have world-class instant payment infrastructure (FPS) that was ahead of its time, near universal smartphone adoption, and implicit government alignment through the National Payments Vision. The question isn't whether contactless A2A payments will happen - it's whether the UK leads or follows.

**Low Implementation Risk:**

- Leverages existing, proven infrastructure (FPS has handled billions of transactions)
- Uses established security models (banking app authentication)
- Minimal technical complexity for banks (weeks, not years, to implement)

**High Strategic Reward:**

- £9bn potential GDP uplift ([EY report, March 2025](https://www.ey.com/content/dam/ey-unified-site/ey-com/en-uk/generic/documents/ey-uk-account-to-account-payment-infrastructure-03-2025.pdf))
- Reduced cost burden on UK businesses (£5bn annual card fees)
- Enhanced consumer protection through explicit transaction consent
- True payment sovereignty using British infrastructure

While other nations have built new infrastructure from scratch (UPI, PIX), the UK can catch-up and even leapfrog them by combining existing instant payments with modern mobile interfaces. This isn't merely reaching par for the course - it's potentially setting a new global standard for how established economies can modernize payments - just as the UK GDS is world leading and widely respected when it comes to online usability.

**Contactless A2A payments must be an innovation priority in the UK.**

The technical path is clear, the economic case is compelling, and the timing aligns with national strategy. The only question is whether we move decisively or let the opportunity pass while others continue to extract value via unnecessary complexity.

## Join Us

The organisation is managed via GitHub:

* [https://github.com/Better-Mobile-Payments-UK/](https://github.com/Better-Mobile-Payments-UK/)

If you work at an FCA authorised or Open Banking registered entity, or have an interest in making life better for us all, please make an issue requesting membership and we will respond ASAP.
