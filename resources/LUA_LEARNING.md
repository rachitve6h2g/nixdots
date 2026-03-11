## Phase 1: The Syntax Sprint (Easy/Quick)

_Goal: Bridge the gap between Python/C logic and Lua's unique syntax._

### 1. [Learn Lua in Y Minutes](https://learnxinyminutes.com/docs/lua/)

**Description:** A single-page, code-heavy "cheat sheet" that demonstrates variables, loops, and functions.

### 2. [Lua-Users Wiki: Tutorial Directory](http://lua-users.org/wiki/TutorialDirectory)

**Description:** A community-maintained collection of short tutorials on specific topics (e.g., String manipulation, scope).

---

## Phase 2: Fundamental Mastery (Intermediate/Structured)

_Goal: Understand the "philosophy" of Lua and its only data structure: The Table._

### 3. [Programming in Lua (PiL), 1st Ed.](https://www.lua.org/pil/contents.html)

**Description:** The definitive book by Roberto Ierusalimschy (Lua's creator). The first edition is free online.
**Why for you:** It is widely considered one of the best-written programming books. It explains _why_ the language is designed with such a small footprint.
**Note:** While based on Lua 5.0, 90% of the concepts are still the "source of truth" for modern versions.

### 4. [Lua 5.4 Reference Manual](https://www.lua.org/manual/5.4/)

**Description:** The "dry" technical specification.
**Why for you:** Since you know C, you will appreciate the precision here. It contains the complete C API, which explains how Lua manages its virtual stack—essential if you ever want to extend your Nix/C tools with Lua.

---

## Phase 3: The "Lua-isms" & Meta-Programming (Hard/Sophisticated)

_Goal: Learn how Lua builds complex systems out of simple parts._

### 5. [Metatables and Metamethods Guide](http://lua-users.org/wiki/MetatableEvents)

**Description:** Deep dive into how Lua handles operator overloading and object-oriented patterns.
**Why for you:** This is Lua's version of Python's "Dunder" methods (`__init__`, `__add__`). It is the key to understanding how Neovim plugins or game engines "stretch" the language.

### 6. [The Implementation of Lua 5.0 (White Paper)](https://www.lua.org/doc/jucs05.pdf)

**Description:** A technical paper explaining the register-based virtual machine architecture.
**Why for you:** Given your C background, seeing how the Lua VM handles instructions compared to other stack-based VMs (like the JVM) provides a deep appreciation for its speed and efficiency.

---

## Phase 4: Practical Application (The "Project" Layer)

_Goal: Applying Lua to your specific goal of a digital note system._

### 7. [Neovim Lua Guide (nvi-lua-guide)](https://github.com/nanotee/nvim-lua-guide)

**Description:** A comprehensive guide to using Lua specifically as a configuration and plugin language.
**Why for you:** Since you are building a computer-based note system and moving away from Emacs, this is your practical "lab." It teaches you how to use Lua to bridge the gap between text files and a searchable UI.

### 8. [Luvit / Luv Documentation](https://github.com/luvit/luv/blob/master/docs.md)

**Description:** Documentation for the Libuv bindings for Lua.
**Why for you:** If you want your note-taking system to handle file-system watching (like auto-indexing notes when they change), this is the "hard-mode" way to handle asynchronous I/O in Lua.

---

## Phase 5: Alternative Priorities (Video Lectures)

_If you need a break from reading, use these as a secondary supplement._

1. **CS50’s Introduction to Game Development (Lua/LÖVE):** Search for the "Flappy Bird" or "Pong" lectures on YouTube. Even if you aren't making games, it shows Lua handling real-time logic.
2. **Derek Banas' "Lua in One Video":** A rapid-fire visual summary of the syntax if you prefer hearing the concepts while seeing the code typed out.
