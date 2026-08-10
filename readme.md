# 🦅 Who's That Bird?

> A Prolog-powered expert system that identifies Mexican birds — one question at a time.

Inspired by the *"Who's That Pokémon?"* segment, **Who's That Bird?** is an interactive web app that identifies birds through a series of questions about size, color, habitat, and behavior. The inference engine runs entirely in the browser using Prolog logic — no backend required.

---

## 🧠 How It Works

The app walks you through a series of questions. Behind the scenes, a Prolog expert system eliminates candidates until only one bird matches your answers. Once identified, the bird is revealed with a photo, its scientific name, habitat info, diet, and a fun fact.

```
User answers questions → tau-Prolog runs inference → Bird identified → Info + photo displayed
```

---

##  Tech Stack

| Layer | Technology |
|---|---|
| Expert system | Prolog (`birds.pl`) |
| Prolog in the browser | [tau-Prolog](http://tau-prolog.org/) |
| Frontend | HTML / CSS / Vanilla JS |
| Bird data | `birds.json` (local) |
| Photos | Wikimedia Commons (free license) |

No server. No framework. No build step. Just open `index.html`.

---

##  Birds in the Knowledge Base

| Bird | Scientific Name | Habitat |
|---|---|---|
| Paloma Común | *Columba livia* | Urban |
| Gorrión Común | *Passer domesticus* | Urban |
| Cardenal Norteño | *Cardinalis cardinalis* | Forest |
| Cuervo Común | *Corvus corax* | Varied |
| Colibrí | *Trochilidae spp.* | Garden |
| Águila Real | *Aquila chrysaetos* | Mountain |
| Tucán Pico Canoa | *Ramphastos sulfuratus* | Jungle |
| Perico Verde | *Aratinga holochlora* | Jungle |
| Búho Cornudo | *Bubo virginianus* | Forest |
| Flamingo Rosa | *Phoenicopterus ruber* | Coast |
| Pato de Collar | *Anas platyrhynchos* | Lake |
| Lechuza de Campanario | *Tyto alba* | Urban |
| Pelícano Blanco | *Pelecanus erythrorhynchos* | Coast |
| Cenzontle | *Mimus polyglottos* | Urban |

---

## Project Structure

```
whos-that-bird/
│
├── index.html          # Main entry point
├── style.css           # Styles
├── app.js              # Tau-Prolog integration + UI logic
│
├── prolog/
│   └── birds.pl        # Expert system — rules & inference
│
├── data/
│   └── birds.json      # Bird info: description, habitat, diet, fun facts
│
└── img/
    └── *.jpg           # Bird photos (Wikimedia Commons)
```

---

## 🚀 Running Locally

No installation needed.

```bash
git clone https://github.com/your-username/whos-that-bird.git
cd whos-that-bird
# Open index.html in your browser
```

> Some browsers block local file loading. If tau-Prolog can't load `birds.pl`, serve the folder with a local server:
> ```bash
> python -m http.server 8000
> # then open http://localhost:8000
> ```

---

## 📚 About the Expert System

The Prolog knowledge base was built as part of a **Formal Languages and Automata** course at [TecNM Saltillo](https://saltillo.tecnm.mx/). It uses classic expert system techniques:

- `ask/2` with cut (`!`) for deterministic attribute queries
- `menuask/3` for menu-driven selection
- Dynamic facts via `assert/retract` to store user answers during a session
- Backward chaining through `bird/1` rules to reach a conclusion

The inference logic follows patterns from *Prolog Programming in Depth* — Covington, Nute & Vellino.

---

## Why Mexican Birds?

Mexico is one of the most biodiverse countries on the planet — home to over 1,000 bird species. This project focuses on birds found across Mexican territory, with special attention to species present in northeastern Mexico (Coahuila and surrounding states).

---

## 🔭 Roadmap

- [ ] Add more Mexican bird species to the knowledge base
- [ ] Silhouette reveal animation (Pokémon-style)
- [ ] Quiz mode — you guess the bird from clues
- [ ] Filter by Mexican region
- [ ] Confidence scoring when no exact match is found

---