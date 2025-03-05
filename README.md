# SeznamTask - Aplikace pro vyhledávání knih

Tento projekt je jednoduchá iOS aplikace vyvinutá ve **SwiftUI**, která umožňuje uživatelům vyhledávat knihy podle jména autora a zobrazovat podrobnosti o knihách. Aplikace využívá **Coordinator pattern** pro navigaci a načítá data z externího API (např. Google Books API).

## Funkce

1. **Vyhledávání knih podle autora**:
   - Uživatel zadá jméno autora.
   - Aplikace zobrazí seznam knih od daného autora, které vyšly v češtině.

2. **Detail knihy**:
   - Kliknutím na položku v seznamu se uživatel dostane na detail knihy.

## Požadavky

- **iOS 16+**
- **Xcode 14+**
- **API klíč** (např. z Google Books API)

## Jak spustit projekt

### 1. Naklonování repozitáře

Nejprve naklonuj repozitář:
```bash
git clone https://github.com/LukasSkrivanek/SeznamTask.git
cd SeznamTask
