# 🔷 Holomorph and Regular Subgroups Toolkit

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![GAP](https://img.shields.io/badge/GAP-4.11-blue)
![Python](https://img.shields.io/badge/Python-3.7%2B-blue)

A GAP package for studying **holomorphs** of groups, their **regular subgroups**, and associated **gamma functions**.  
Includes functions for constructing holomorphs, computing regular subgroups, exploring gamma functions, and visualizing normalizing graphs using Python.

---

## 📂 Project structure

```bash
holomorph-toolkit/
├── LICENSE                  # License file (MIT)
├── README.md                # This documentation
├── holomorph_toolkit.g      # GAP code for holomorphs and gamma functions
├── NEOgraph.py              # Example generated Python visualization script
├── images/                  # Example outputs
│   ├── 12-2.png
│   ├── 24-2.png
│   └── 24-3.png              
```

---

## ✨ Features

- Abstract and permutational holomorph construction
- Extraction of all regular subgroups of the holomorph
- Gamma function computations and evaluations for regular subgroups
- Circle operation (induced by the gamma function) and power computations on group elements
- Visualization scripts for normalizing graphs with node coloring
- Utilities for group-theoretic calculations

---

## 📦 Installation

This toolkit is designed to run within GAP (Groups, Algorithms, Programming), a system for computational discrete algebra.
To use it, ensure you have GAP version 4.11 or later installed: https://www.gap-system.org.

Additionally, to enable graph visualization features, you’ll need Python 3.7+ along with the following packages installed:

```bash
pip install matplotlib networkx numpy
```

Download or clone this repository 

```bash
git clone  https://github.com/fspaggiari/holomorph-toolkit.git
```

and load the GAP code with:

```bash
Read("holomorph_functions.g");
```

---

## 🛠️ Usage

Load the GAP functions, then you can call, for example:

```bash
G := CyclicGroup(IsPermGroup, 16);
reg_subgroups := allRegularSubgroupsHolomorph(G);
normalizing_graph := NEO(G);  # Constructs and visualizes the normalizing graph
```

Python visualization script NEOgraph.py is generated automatically and launched in background.

---

## 📄 License

This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute this software with proper attribution.

---

## 🤝 Contributions

Contributions are welcome!

If you have ideas for improvement, bug reports, or would like to add new features:

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

Please ensure your code is clean, documented, and tested. Thank you!