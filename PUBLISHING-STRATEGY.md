# Publishing strategy — Paraxiom Identity Architecture

> How and where to publish each artifact of the identity architecture
> so it functions as foundational infrastructure rather than as
> NeoCarbone-internal code.
>
> Companion to:
> - `main.tex` / `build/main.pdf` — the formal treatise
> - NC repo `IDENTITY-PALLETS-DESIGN.md` — engineering spec
> - NC repo `IDENTITY-SUBSTRATES.md` — multi-chain + ephemeral spec
> - NC repo `GOV-APP-IDENTITY-AND-ERASURE.md` — first-consumer impl
>
> Last updated: 2026-05-16.

## Branding decision (2026-05-16)

The identity architecture is **Paraxiom-namespaced** (`paraxiom-*` on
crates.io, `@paraxiom/*` on npm, `paraxiom-identity*` on PyPI). The
treatise is `Paraxiom/identity-architecture` on GitHub.

The first deployment of the Paraxiom-V.I.A. augmented-democracy
framework is **NeoCarbone Governance** — the multi-stakeholder
governance application running at NeoCarbone (currently at
`148.113.197.101/#governance`, target HTTPS hostname pending). NC
Governance consumes the Paraxiom identity substrate and applies it to
the FieldNOW product context.

This split — Paraxiom-foundation + NC-Governance-as-first-deployment +
NeoGen-as-pipeline + FieldNOW-as-product — establishes the
narrative for academic citation, standards-body submission, and
external pitches (DND, CCCS, BoE, Numana, etc.):

> *"Paraxiom Technologies provides the post-quantum identity
> substrate and the augmented-democracy framework. NeoCarbone
> Governance is the first deployment. NeoGen is the spec-driven
> generation pipeline. FieldNOW is the customer product."*

---

## §1 Why publish

The architecture is foundational infrastructure. Identity is needed by:

- **NeoCarbone FieldNOW** — the v0.1 consumer (governance app)
- **Future municipal-governance pilots** — Paraxiom × V.I.A. work
- **Future enterprise-compliance pilots** — same architecture, different
  governance bodies
- **Any third party** who wants to interop with Paraxiom-anchored
  identities (chain or IPFS payloads)

If the implementation only lives in `Neo-Carbone/neogen-pipeline`, every
downstream consumer must read NC's code and copy it. That is the
opposite of foundational infrastructure. Each consumer should:

1. Pull a versioned, signed package from a public registry
2. Get type definitions that compile against the consumer's language
3. Have a clear contract for upgrades (SemVer)
4. Be able to cite the treatise (DOI) in their own publications

The publishing strategy makes this possible without locking anyone
into NC-specific patterns.

---

## §2 What goes where

The architecture has eight layers; each maps to its right home.

| # | Layer | Current location | Right location | Format | Registry |
|---|---|---|---|---|---|
| 1 | **Treatise** (theorems, proofs, formal spec) | `Paraxiom/identity-architecture` | Same + DOI | PDF + LaTeX | **Zenodo** (DOI) + optional arxiv preprint |
| 2 | **SQL reference schema** | NC `db/init-identity.sql` | `Paraxiom/identity-schema` | `.sql` files | GitHub releases |
| 3 | **Rust types** (Identity, Stratum, DelegationCert, ScopeClaim, GovernanceLevel, etc.) | Inline in QH pallets | `Paraxiom/paraxiom-identity-types` | Rust crate | **crates.io** |
| 4 | **Substrate pallets** (identity-registry, governance-bodies, credential-vault, etc.) | QH pallets dir | Stay in QH; publish wrappers | Rust crates | **crates.io** as `paraxiom-pallet-*` |
| 5 | **TypeScript types** (matching Rust) | Inline in NC | `Paraxiom/identity-types-ts` | TS package | **npm** as `@paraxiom/identity-types` |
| 6 | **TypeScript client SDK** | NC handwritten fetch calls | `Paraxiom/identity-client-ts` | TS package | **npm** as `@paraxiom/identity-client` |
| 7 | **Python client SDK** | Does not exist | `Paraxiom/identity-client-py` | Wheel | **PyPI** as `paraxiom-identity` |
| 8 | **React UI components** (identity switcher, my-contributions panel) | NC `src/` | `Paraxiom/identity-ui-react` | TS package | **npm** as `@paraxiom/identity-ui` |
| 9 | **`paraxiom-id` CLI** (ephemeral identity tooling) | Spec'd in IDENTITY-SUBSTRATES.md, not built | `Paraxiom/paraxiom-id` | Rust binary | **crates.io** binary; optional Homebrew tap |
| 10 | **Reference container images** (gov-app, chain node, attestation endpoint) | Live on NC VPS | Same images, publish to public registry | OCI | **GHCR** (`ghcr.io/paraxiom/*`) |

---

## §3 License posture per format

Both licenses already declared in `LICENSE-CODE` (Apache 2.0) and
`LICENSE-TEXT` (CC BY-SA 4.0). Each registry has its own metadata
convention:

| Registry | License declaration |
|---|---|
| **Zenodo** | `creators` + `license: "CC-BY-SA-4.0"` in deposit metadata |
| **crates.io** | `license = "Apache-2.0"` in `Cargo.toml` |
| **npm** | `"license": "Apache-2.0"` in `package.json` |
| **PyPI** | `license = {file = "LICENSE-CODE"}` in `pyproject.toml`, classifier `License :: OSI Approved :: Apache Software License` |
| **GitHub releases** | `LICENSE-CODE` + `LICENSE-TEXT` files at repo root |
| **GHCR (container)** | `LABEL org.opencontainers.image.licenses="Apache-2.0"` in Dockerfile |

The combined posture: **code Apache 2.0 (permissive, patent grant);
text + diagrams CC BY-SA 4.0 (share-alike on derivatives)**.

---

## §4 Sequencing — what to publish first

Phase ordering by leverage and dependency:

### Phase 0 — Establish citation (1 day)

**Zenodo DOI for the treatise.** Paraxiom already has a Zenodo
account (per memory: 18 existing Zenodo publications, latest AB
Coherence at DOI 10.5281/zenodo.19402705). Add this one:

- Title: *Identity as Accountability Chain: A Post-Quantum Architecture
  for Persistent Identity Across Human, Machine, and AI Agent
  Substrates*
- Author: Cormier, S. (ORCID required)
- Communities: cs.CR (cryptography + security)
- Related identifiers: link to GitHub repo
- License: CC BY-SA 4.0
- File: `build/main.pdf`
- Keywords: digital identity, post-quantum, accountability,
  agent identity, substrate attestation, decentralized identity

After deposit, get DOI; update `main.tex` and the README to cite the
DOI; this becomes the citable reference for everything downstream.

### Phase 1 — Claim namespaces (1 day)

Claim publishing namespaces on three registries BEFORE squatters. Each
needs a minimal placeholder package published, then iterated:

- **crates.io** `paraxiom-*` namespace: there is no org concept on
  crates.io; the first crate published with the prefix effectively
  claims it. Publish `paraxiom-identity-types` v0.0.1 with just type
  stubs to claim the prefix.
- **npm** `@paraxiom` scope: create the Paraxiom org on npm (needs
  npm account; Apache 2.0 friendly); publish `@paraxiom/identity-types`
  v0.0.1 to claim the scope.
- **PyPI** `paraxiom-*` prefix: PyPI has no namespaces; first
  publication of `paraxiom-identity` claims the name. Worth doing
  defensively even if Python SDK is later.

### Phase 2 — Type definitions (3-5 days)

**`paraxiom-identity-types` (crates.io)** — Rust:

- Identity struct (with stratum, parent_identity, etc.)
- Stratum enum (S1Person, S2Scoped, S4AgentInstance, S5CrossTenant)
- GovernanceLevel enum (G0-G7)
- ScopeClaim variants
- DelegationCert struct + serialization
- CredentialKind / EphemeralIdentity YAML types
- CAIP-10 address parsing

Should derive `Serialize`, `Deserialize`, `Clone`, `Debug` for everything.
Add `ts-rs` derive so TypeScript types auto-generate from the Rust
source. This makes Phase 3 (npm package) a build-step, not a hand-port.

**`@paraxiom/identity-types` (npm)** — TypeScript:

- Generated from Rust via `ts-rs`
- Re-exports + ergonomic helpers
- Zero runtime dependencies (just types)

### Phase 3 — Reference schema (2 days)

**`Paraxiom/identity-schema`** repo:

- `schema.sql` — clean Postgres DDL for the full identity model
  (extracted from NC's `db/init-identity.sql` but generalized)
- `migrations/` — versioned migrations (v1 → v2 etc.)
- `README.md` — how to apply against a fresh Postgres
- `docker-compose.yml` — bring up a clean reference instance
- `tests/` — pgtap tests verifying constraints

Distributed as GitHub release tarball; no package registry (SQL has
no real registry).

### Phase 4 — Client SDKs (1-2 weeks)

**`@paraxiom/identity-client` (npm)** — TypeScript client:

- Wraps the gov-app endpoints (`/identities/*`, `/contributions/*`,
  etc.) as a typed client
- Pluggable transport (fetch, axios, node-fetch)
- Auth provider abstraction (cookie, JWT, paraxiom-id ephemeral)
- React hooks layer optional (`useActiveIdentity`, `useContributions`)

**`paraxiom-identity` (PyPI)** — Python client:

- Same endpoint coverage as TS
- Async + sync APIs
- Type stubs derived from the Rust types (via `pydantic` generation
  from JSON Schema)

**Rust client crate (`paraxiom-identity-client`)** — same shape as
Python; uses `reqwest` + `tokio`. Important for server-side Rust
consumers and CLIs.

### Phase 5 — `paraxiom-id` CLI (1 week)

**`Paraxiom/paraxiom-id`** repo:

- Implementation of IDENTITY-SUBSTRATES.md §3-§5
- Subcommands: `keygen`, `delegate`, `sign`, `verify`, `validate`,
  `import-caip10`
- YAML config file loader
- Multi-algorithm support: Ed25519, Falcon-512, SPHINCS+-256f-simple
- Distributable via:
  - `cargo install paraxiom-id`
  - Pre-built binaries on GitHub Releases (linux/macOS/win)
  - Homebrew tap: `brew install paraxiom/tap/paraxiom-id`

### Phase 6 — UI components (1-2 weeks)

**`@paraxiom/identity-ui` (npm)** — React components:

- `<IdentitySwitcher />` — the top-bar dropdown
- `<MyContributions />` — the contributions panel + erasure
- `<NewIdentityDialog />` — modal
- `<IdentityCard />` — detail view
- `<PrivacyPostureSelector />` — Π0-Π4 chooser per action
- Storybook + Chromatic for visual testing
- Themable via CSS variables (gov-app sets brand; municipal pilots
  set theirs)

Only published AFTER NC gov-app has battle-tested the components.
Avoids shipping unstable components.

### Phase 7 — Reference container images (parallel anytime)

**GHCR** under `ghcr.io/paraxiom/`:

- `paraxiom/identity-attestation-endpoint` — reference attestation
  endpoint (per IDENTITY-SUBSTRATES.md §3)
- `paraxiom/identity-schema-postgres` — Postgres pre-seeded with
  the reference schema
- `paraxiom/paraxiom-id-cli` — the CLI image for CI use

---

## §5 Versioning policy

All packages follow **SemVer**:

- **MAJOR** version bumps on breaking type changes (e.g., renaming a
  Stratum variant, removing a field from Identity)
- **MINOR** bumps on additive type changes (new Stratum variant, new
  optional field)
- **PATCH** bumps on bug fixes and clarifications

Pre-1.0 (which is where we start), MINOR bumps may include breaking
changes per SemVer convention.

The treatise itself follows a document version (v1.0 currently); each
major treatise revision triggers a MAJOR-version bump across the
ecosystem.

---

## §6 Coordinated release artifact

After Phase 2-3 ship, a single coordinated release should publish:

- `paraxiom-identity-types@0.1.0` (crates.io)
- `@paraxiom/identity-types@0.1.0` (npm)
- `paraxiom-identity-schema-v1` GitHub release (identity-schema repo)
- Updated `Identity as Accountability Chain v1.0` PDF on Zenodo

All four references each other in their metadata:

- Cargo.toml `documentation = "https://doi.org/..."`
- package.json `"homepage": "https://doi.org/..."`
- schema README: "Implements the model in Cormier (2026), DOI ..."
- Zenodo "related identifiers": all three GitHub repos + crates.io + npm

This is the **establishing-a-base moment**: any downstream consumer can
now cite the DOI, install the types from their language's registry,
apply the schema, and have a working base.

---

## §7 Status tracker

| Artifact | Status | Owner | ETA |
|---|---|---|---|
| Treatise PDF v1.0 | ✅ Published in `Paraxiom/identity-architecture` | Sylvain | done |
| LICENSE-CODE / LICENSE-TEXT / NOTICE | ✅ Added | Sylvain | done |
| Zenodo deposit | ⏳ Pending (needs Paraxiom Zenodo + DOI) | Sylvain | 1 day |
| `paraxiom-identity-types` v0.0.1 (crates.io claim) | ⏳ Not started | TBD | 1 day to claim |
| `@paraxiom/identity-types` v0.0.1 (npm claim) | ⏳ Not started | TBD | 1 day to claim |
| `paraxiom-identity` v0.0.1 (PyPI claim) | ⏳ Not started | TBD | 1 day to claim |
| `paraxiom-identity-types` v0.1.0 (real types) | ⏳ Not started | TBD | 3-5 days |
| `@paraxiom/identity-types` v0.1.0 (TS port) | ⏳ Not started | TBD | 1 day after Rust |
| `Paraxiom/identity-schema` repo | ⏳ Not started | TBD | 2 days |
| NC gov-app v0.2 (first consumer reference impl) | 🟡 Backend pushed, UI + migration pending | Sylvain | 2-3 days |
| Reference attestation endpoint | ⏳ Not started | TBD | 1 week |
| `paraxiom-id` CLI | ⏳ Not started | TBD | 1 week |
| `@paraxiom/identity-client` SDK | ⏳ Not started | TBD | 1 week |
| `paraxiom-identity` Python SDK | ⏳ Not started | TBD | 1 week |
| `@paraxiom/identity-ui` React components | 🟡 Defer until NC v0.2 ships | TBD | 1-2 weeks post-NC |

---

## §8 Defensive namespace claims — checklist

Before announcing the architecture publicly (e.g., at Numana, CCCS,
DND, BoE meetings), claim the following to prevent typosquatting and
hostile actors:

- [ ] **GitHub org** `Paraxiom` — already claimed ✅
- [ ] **crates.io** — publish `paraxiom-identity-types` v0.0.1 (any
  minimal valid crate) to establish the `paraxiom-*` convention
- [ ] **npm** — create org `paraxiom`, publish `@paraxiom/identity-types`
  v0.0.1 to claim the `@paraxiom/*` scope
- [ ] **PyPI** — publish `paraxiom-identity` v0.0.1 (any minimal valid
  package) to claim the name
- [ ] **Zenodo** — deposit the treatise (Paraxiom already has org
  account)
- [ ] **GHCR** — push a placeholder `ghcr.io/paraxiom/identity-types:0.0.1`
- [ ] **DNS** — `paraxiom.org` already owned ✅; consider
  `paraxiom.dev` for developer surface
- [ ] **Homebrew tap** — `paraxiom/homebrew-tap` repo on GitHub
- [ ] **Discord / Telegram / community** — defer until ready to
  support inbound

---

## §9 Discoverability

Each published artifact should advertise the others. Concretely:

- **Zenodo deposit description** lists all the package registries
- **crates.io README.md** for each crate links to the Zenodo DOI,
  GitHub repo, and other-language packages
- **npm package README** likewise
- **GitHub repo READMEs** all cross-link
- **paraxiom.org** has a landing page `paraxiom.org/identity` linking
  to all of the above, plus the deployed Contributor AI at
  `paraxiom.org:8443`

This makes the architecture discoverable by ecosystem (someone using
Rust finds it via crates.io; someone using TypeScript via npm; someone
reading literature via the DOI; etc.).

---

## §10 Open decisions

1. **Maintainer assignment.** Each artifact needs a maintainer (could
   all be Sylvain for v0; harder to scale). Should there be a
   `paraxiom-identity-maintainers` GitHub team?

2. **Signing.** crates.io supports `cargo crev` signatures; npm
   supports `npm provenance`. Worth enabling from day one for
   foundational packages.

3. **Sponsorship / GitHub Sponsors.** Foundational infrastructure
   could accept sponsorships once recognizable. Defer until first
   real consumer (other than NC) lands.

4. **Standards body submission.** OpenID Foundation has a
   Verifiable Credentials WG; W3C has the DIDs WG. Submitting the
   accountability-chain model to one of these would establish it as
   reference architecture. Worth considering after Zenodo DOI lands.

5. **Numbering vs. naming the model.** The model has theorems labeled
   §5.1 etc. Should we give the model a memorable name (`PXED` for
   Paraxiom Ephemeral Delegation is already in IDENTITY-SUBSTRATES.md;
   consider a model name like `ParaxiomID` or `PXID` for the full
   identity model)? Branding-level question.

---

## §11 Cross-references

- This repo's `README.md` — entry point
- `main.tex` / `build/main.pdf` — the treatise
- NC `IDENTITY-PALLETS-DESIGN.md`, `IDENTITY-SUBSTRATES.md`,
  `FIELDNOW-PERSONAS.md`, `GOV-APP-IDENTITY-AND-ERASURE.md` — first-
  consumer engineering docs

---

## License

CC BY-SA 4.0 — same as the rest of the `Paraxiom/identity-architecture`
treatise text. Source-code artifacts (the crates, packages, schema)
published per-artifact under Apache 2.0.
