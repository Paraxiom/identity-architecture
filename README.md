# Identity as Accountability Chain — Paraxiom treatise

Engineering document and mathematical treatise on identity
architecture: from the founding individuation event through six
accretion layers to the post-quantum chain substrate that makes
identity persistent into a future of human, machine, and AI agent
accountability loci.

## Files

- `main.tex` — the document (~2000 lines LaTeX, ~52 pages PDF)
- `build.sh` — xelatex build script (3-pass; produces both internal + publication PDFs)
- `build/main.pdf` — internal output (includes §14 Implementation roadmap)
- `build/main-zenodo.pdf` — publication output (§14 omitted; uploaded to Zenodo)

## Build

```bash
./build.sh           # builds both internal + publication
./build.sh internal  # internal only
./build.sh publish   # publication only
./build.sh clean     # clean rebuild
```

Requires xelatex with `fontspec`, `unicode-math`, `amsthm`,
`tikz`, `cleveref`, `hyperref`, `booktabs`, `listings`.

## Structure

| § | Topic |
|---|---|
| 1 | Introduction |
| 2 | Formal model (Definitions 2.1–2.4, Axioms 2.5–2.7, §2.5 Sources of identity content, §2.6 Non-consensual third-party identity (out of scope), §2.7 Hypergraph identity state) |
| 3 | Layer theory (the 6 accretion layers) |
| 4 | Founding events across substrates (incl. §4.6 Physical-good founding) |
| 5 | Machine identity storage + Tier monotonicity theorem |
| 6 | Agent identity + Stratum well-foundedness theorem |
| 7 | LLM identity + Instance non-identity theorem |
| 8 | Governance levels and identity participation (chartered scope, multi-level participation, reputation non-transitivity) |
| 9 | Cryptographic substrate + Cryptographic survival theorem |
| 10 | Current digital ID landscape (May 2026) — incl. §10.3 NFT-based identity primitives, §10.7 Positioning fit, §10.8 Positioning vs. W3C VC 2.0 / DIDs 1.1 |
| 11 | Paraxiom architecture + Crypto-shredding completeness theorem + Verification-time accountability theorem |
| 12 | Privacy, anonymity, and user-controlled disclosure (5-tier model, selective-disclosure soundness, unlinkability) |
| 13 | Future scenarios |
| 14 | Implementation roadmap *(internal build only)* |
| 15 | Conclusion |
| A | Detailed proofs (founding uniqueness, stratum well-foundedness, cryptographic survival, crypto-shredding completeness) |
| B | Pallet API specifications |
| C | ZK-augmented pallet extrinsics (v0.3) |
| D | Sources |

## Theorems proven

1. **Founding uniqueness** — every identity locus has exactly one
   founding event (App. A.1)
2. **Tier monotonicity** — permanence non-increasing in tier number
   (proof in §5.6)
3. **Stratum well-foundedness** — every S2/S4/S5 traces to S1 in
   finite steps (App. A.2)
4. **LLM instance non-identity** — different deployment IDs ⇒
   different identity loci (§7.2)
5. **Cryptographic survival** — PQ-signed accretion chains survive
   CRQC; classical do not (App. A.3)
6. **Crypto-shredding completeness** — master-key deletion renders
   ciphertexts inaccessible regardless of pin status (App. A.4)
7. **Verification-time accountability** — `verify_chain` terminates
   correctly in finite steps (§11.7)

## Companion documents

### In this repo

- `PUBLISHING-STRATEGY.md` — how each artifact will be published
  (Zenodo DOI for the treatise, crates.io / npm / PyPI / GHCR for
  code, sequencing + namespace claims)

### In `Neo-Carbone/neogen-pipeline` (first consumer)

- `pipeline/ui/docs/IDENTITY-ARCHITECTURE.md` — markdown narrative version
- `pipeline/ui/docs/IDENTITY-PALLETS-DESIGN.md` — pallet design spec
- `pipeline/ui/docs/IDENTITY-SUBSTRATES.md` — multi-chain + ephemeral identities
- `pipeline/ui/docs/GOVERNANCE-ROADMAP.md` — product roadmap (downstream)

## Citation

> Cormier, S. *Identity as Accountability Chain: A Post-Quantum
> Architecture for Persistent Identity Across Human, Machine, and AI
> Agent Substrates*. Paraxiom Technologies Inc., May 22, 2026.

## Status

v1.0, May 22, 2026. Draft for internal review prior to ADR-0017
architectural session.

## License

This work is offered as a public good. Identity is foundational
infrastructure for humans, machines, and AI agents; no entity should
be able to enclose access to a verifiable accountability primitive.

- **Source code** (Rust, scripts, build tooling): Apache License 2.0
  — see `LICENSE-CODE`.
- **Treatise text, diagrams, theorems, proofs** (`main.tex`,
  `build/main.pdf`, `README.md`, and other prose): Creative Commons
  Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) — see
  `LICENSE-TEXT`.

Derivatives of the text must be share-alike (CC BY-SA 4.0). The
intent is that this architecture remains a public good in perpetuity.
See `NOTICE` for upstream attribution.
