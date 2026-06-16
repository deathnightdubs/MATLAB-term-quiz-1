# ENVE / GEOE 121 — Quiz 1 Master Study Sheet (Topics 1–2)

**Quiz:** Tuesday, June 16, 2026, 4:00 PM (80 minutes), closed book, no calculator/notes.
**Format:** Written/paper. Short-answer, code-reading, **output prediction**, indexing, and code-completion questions.
**Golden rule from the instructor:** *If a MATLAB statement produces an error, write `ERROR`.* (So you must know exactly which statements error and why.)

This sheet is built from L1–L7, the labs, the homework, the worked examples, and the fprintf reference in the repo. Work through every section and reproduce the worked outputs by hand.

---

## TABLE OF CONTENTS
1. Variables, names & basic syntax
2. Constants & comments & line continuation
3. Data types (classes) & type casting
4. Operators & **operator precedence** (the #1 output-prediction topic)
5. Logical & relational expressions
6. Built-in functions (math, trig, rounding, random)
7. `fprintf` formatted printing (complete)
8. `input`
9. Vectors & the colon operator
10. Indexing (vectors & matrices) + conditional/logical indexing
11. Replacing / modifying / deleting elements
12. Concatenation
13. Matrices & matrix-generation functions
14. Matrix math & linear algebra (solving systems)
15. Sorting & filtering data
16. Strings, char vectors & string operations
17. Statements that produce an **ERROR** (memorize this list)
18. Worked engineering examples
19. Rapid-fire output-prediction drills (with answers)

---

## 1. VARIABLES, NAMES & BASIC SYNTAX

**Assignment:** `variable = expression`
- `;` at the end **suppresses** the output display; no `;` echoes the result to the Command Window.
- MATLAB is **case-sensitive**: `mass` and `Mass` are different variables. Referencing an undefined name (e.g. `Mass` when only `mass` exists) → **ERROR** (`Unrecognized function or variable`).

**Legal variable names — ALL rules:**
1. Must **start with a letter**.
2. May contain only **letters, numbers, and underscores** `_`.
3. **Cannot start with a number** (`8val` ❌).
4. **Cannot start with an underscore** (`_col` ❌).
5. **No special characters** or spaces (`-`, `@`, `%`, `#`, space ❌, e.g. `col-03`, `row@3` ❌).
6. *Should* be meaningful (style, not a syntax rule).

| Name | Works? | Why / note |
|------|--------|------------|
| `asdf1` | YES | legal but unintelligible (bad name) |
| `col-03` | NO | `-` not allowed |
| `8val` | NO | cannot start with a number |
| `aaaa3` | YES | legal (poor name) |
| `_col` | NO | cannot start with `_` |
| `row_3` | YES | legal & okay |
| `love` | YES | legal |
| `row@3` | NO | `@` not allowed |

---

## 2. CONSTANTS, COMMENTS & LINE CONTINUATION

**Predefined constants:** `pi` (3.14159…), `i`, `j` (imaginary unit), `Inf` (infinity), `NaN` (Not a Number).
- You *can* overwrite them (`pi = 10;` is allowed but dangerous). Restore the original with `clear pi`.
- MATLAB **looks for variables before functions/constants** — so overwriting `pi`, `sum`, `max`, etc. shadows the built-in until you `clear` it.

```matlab
r = 2;
area1 = pi*r^2     % 12.5664
pi = 10;
area2 = pi*r^2     % 40   (pi is now 10)
clear pi
area3 = pi*r^2     % 12.5664 (restored)
```

**Comments:** `%` starts a comment to end of line. `% Author / % Purpose / % Date Created / % Acknowledgements` header block is the course standard.

**Continuation operator `...`** tells MATLAB the command continues on the next line (use it for long equations or long strings inside `fprintf`).

**Housekeeping commands:** `clear` (wipe variables), `clc` (clear Command Window), `close all` (close figures), `clear all` (wipe everything).

---

## 3. DATA TYPES (CLASSES) & TYPE CASTING

Check a type with **`class(x)`**. Common classes:

| Created by… | Class | Example |
|-------------|-------|---------|
| a normal number | `double` (default) | `x = 3.14;` |
| `int8/16/32/64(...)` | integer | `int32(10)` |
| `true` / `false` | `logical` | `flag = true;` |
| **single** quotes `' '` | `char` | `a = 'A';` |
| **double** quotes `" "` | `string` | `b = "Hi";` |

**Type casting = converting one class to another** (function name = type name). Casting can change the **value**, not just the class:

```matlab
x = 1.7;          % double
a = int32(x);     % a = 2   (rounds to nearest; decimal LOST)
b = double(a);    % b = 2.0 (NOT 1.7 — the decimal is gone)
```

**Numeric ↔ logical:**
- `logical(x)` → `0` if `x==0`, else `1` (any nonzero → `1`, e.g. `logical(-7)=1`).
- A logical added to a number returns a **double** (`true + 3 = 4`, class double).

**Numeric ↔ char/string (KEY for the quiz):**
- `double('9')` → **57** (the ASCII code). `char(57)` → `'9'`.
- Doing arithmetic/relational ops on a **char** implicitly casts it to its ASCII number.
- `str2num('9')` → `9` (numeric, "face value"). `num2str(9)` → `'9'` (text).
- `str2num` / `num2str` convert **text ↔ number by face value**; `double`/`char` convert via **ASCII code**.

ASCII landmarks worth memorizing: `'0'`=48 … `'9'`=57; `'A'`=65 … `'Z'`=90; `'a'`=97 … `'z'`=122; space `' '`=32.

```matlab
x = '9'; class(x)   % char
a = double(x)       % 57  (ASCII)
b = str2num(x)      % 9   (face value)
c = num2str(b)      % '9'
class(c)            % char
```

---

## 4. OPERATORS & OPERATOR PRECEDENCE  ⭐ (most common output-prediction trap)

**Kinds of operators:** construction `[ ]`, unary (e.g. negation `-`, not `~`), binary (`+ - * / ^` etc.), specialized/grouping `( )`.

**Numeric operators:** `+  -  *  /  ^`  (`^` = exponentiation).

### PRECEDENCE — highest to lowest (memorize exactly)
1. `( )` parentheses (innermost first)
2. `^` exponentiation
3. unary `-` (negation) and `~` (not)
4. `*  /  \` (all multiplication & division)
5. `+  -` (addition & subtraction)
6. `<  >  <=  >=  ==  ~=` (all relational)
7. `&&` (AND)
8. `||` (OR)

Within the same level, evaluate **left to right**.

**Classic gotchas:**
- `-10^2` = **−100** (`^` before unary `−`: it's `-(10^2)`).
- `10^2*3` = **300** (`^` then `*`).
- `10^(2+3)` = **100000**.
- `4-3*2` = **−2** (`*` before `−`).
- `2 * -3 ^ 3 + 4` = `2*(-(3^3))+4` = `2*(-27)+4` = **−50**.
- Chained relations are legal but misleading: `2 < 4 < 3` = `(2<4)<3` = `1<3` = **1 (true)**. (Mathematically nonsense — the instructor warns against writing these.)
- `3 < 1 + 3` = `3 < 4` = **1** (relational is lower precedence than `+`).
- `(3 < 1) + 3` = `0 + 3` = **3**.

---

## 5. LOGICAL & RELATIONAL EXPRESSIONS

**Relational (compare numbers → logical 1/0):** `>  <  >=  <=  ==  ~=`
- `==` is equality (two equals); `=` alone is assignment. `~=` is "not equal".

**Logical operators:**
| Use | Scalar (single true/false) | Element-wise (arrays) |
|-----|---------------------------|------------------------|
| NOT | `~` | `~` |
| AND | `&&` | `&` |
| OR  | `\|\|` | `\|` |

- `&&` / `||` are for **single** logical values (and "short-circuit"). `&` / `|` operate **element-by-element** on arrays.
- **In an `if` condition you need ONE true/false**, so use `&&`/`||` with scalars. For arrays use `&`/`|`. Example from course notes:
  - `if vec1 > 4 && vec2 <= 3` is wrong because `vec1>4` is a *vector* `[0 1 0 1]`, not a single value → use `&`.

**Truth table:**
| x | y | ~x | x\|\|y | x&&y |
|---|---|----|-------|------|
| T | T | F | T | T |
| T | F | F | T | F |
| F | T | T | T | F |
| F | F | T | F | F |

**Worked logicals (predict these):**
```matlab
(10 > 4) && (4 > 1)        % 1
(10 < 4) && (4 < 1)        % 0
~((10 < 4) && (4 < 1))     % 1
3 < 10 < 7                 % (3<10)<7 = 1<7 = 1
3 < 10 && 10 < 7           % 1 && 0 = 0
~(5 ~= 10/2)               % 10/2=5, 5~=5 is 0, ~0 = 1
```

**Checking "all three different" (HW trap):** do NOT write `x ~= y ~= z`. Compare pairwise:
`(x~=y) && (x~=z) && (y~=z)`.

**Character class tests (HW Q2 style):**
- Is char a digit `'0'`–`'9'`?  `ch>='0' && ch<='9'`
- Is non-alphanumeric? `~((ch>='0'&&ch<='9') || (ch>='A'&&ch<='Z') || (ch>='a'&&ch<='z'))`

**String `+`:** double-quoted **strings** concatenate with `+`: `"Hello" + " " + "World"` → `"Hello World"`. **Char** vectors do **not** add as text — `+` casts them to ASCII numbers.

---

## 6. BUILT-IN FUNCTIONS

**Syntax:** `out = fun(arg1, arg2, ...)`. Call by name + parenthesized arguments. Functions can be shadowed by variables of the same name (`clear` to restore).

### Common math
| Function | Does | Example → result |
|----------|------|------------------|
| `sqrt(x)` | square root | `sqrt(25)` → 5 |
| `nthroot(x,n)` | real nth root | `nthroot(-27,3)` → −3 |
| `abs(x)` | absolute value | `abs(-7.8)` → 7.8 |
| `sign(x)` | −1/0/+1 by sign | `sign(-5)` → −1, `sign(0)` → 0 |
| `factorial(n)` | n! | `factorial(5)` → 120, `factorial(0)` → 1 |
| `rem(x,y)` | remainder of x/y | `rem(25,4)` → 1, `rem(9,5)` → 4 |

### Exponential / log
| Function | Does | Example → result |
|----------|------|------------------|
| `exp(x)` | e^x | `exp(2)` → 7.3891 |
| `log(x)` | **natural** log (ln) | `log(exp(2))` → 2 |
| `log10(x)` | base-10 log | `log10(1000)` → 3 |
| `log2(x)` | base-2 log | `log2(16)` → 4 |

⚠ MATLAB has **no `ln` function** — `log` *is* the natural log. Logs of 0 give `-Inf`; logs of negatives give complex numbers (no error).

### Trigonometric (⚠ RADIANS by default)
`sin cos tan sec csc cot` take **radians**. `sin(pi/6)` → 0.5, `cos(pi/6)` → 0.8660, `tan(pi/6)` → 0.5774.
- For **degrees**, append `d`: `sind(30)` → 0.5.
- For **inverse**, prepend `a`: `asin(x)`, `asind(x)`.

### Rounding (know the differences!)
| Function | Rounds toward | `-0.6` | `-0.3` | `0.3` | `0.6` |
|----------|---------------|------|------|-----|-----|
| `round(x)` | nearest integer | −1 | 0 | 0 | 1 |
| `fix(x)` | **toward zero** (truncate) | 0 | 0 | 0 | 0 |
| `floor(x)` | toward −∞ | −1 | −1 | 0 | 0 |
| `ceil(x)` | toward +∞ | 0 | 0 | 1 | 1 |

### Random numbers
| Function | Returns |
|----------|---------|
| `rand` | uniform real in (0,1) |
| `randn` | standard normal (mean 0, std 1) |
| `randi([lo,hi])` | uniform **integer** in [lo,hi] |
| `rng(seed)` | sets seed (`'default'`, `'shuffle'`, or an integer) for repeatable results |

Trick: `rand*15` → real in (0,15); `rand*60 + 20` → real in (20,80); `randi([70 130])` → integer 70–130.

---

## 7. `fprintf` — FORMATTED PRINTING (full reference)

**Syntax:** `fprintf(formatSpec, var1, var2, ...)`
- `formatSpec` is text in `' '` or `" "` containing **format operators** and **escape characters**.

**Format operator anatomy:** `% [flags][width][.precision] conversion`

**Conversion characters:**
| Code | Meaning |
|------|---------|
| `%d` or `%i` | integer (base 10) |
| `%u` | unsigned integer |
| `%f` | fixed-point decimal |
| `%e` / `%E` | scientific notation (e.g. `3.141593e+00`) |
| `%g` / `%G` | compact of `%e`/`%f`, no trailing zeros |
| `%c` | single character |
| `%s` | character vector / string |
| `%o`, `%x`, `%X` | octal, hex (lower/upper) |

**Field width & precision:** `%[width].[precision]conv`
- `%5.1f` → width 5, 1 decimal: `8.2345` prints as `  8.2` (padded to 5 chars).
- `%10.2f` → width 10, 2 decimals: `123.4567` → `    123.46`.
- `%.4f` → 4 decimals, `pi` → `3.1416`. `%.2e` → `6.47e+08`. For `%g/%G`, precision = **significant digits** (`%.4g` of pi → `3.142`).
- `%14i` reserves 14 spaces (right-justified, padded with spaces).
- `%6.2s` of `'Samuel'` → `    Sa` (only 2 chars, width 6).

**Flags:** `-` left-justify, `+` always show sign, `' '` leading space, `0` zero-pad, `#` keep decimal point/prefix.

**Escape / special characters:**
| Sequence | Meaning |
|----------|---------|
| `\n` | new line |
| `\t` | horizontal tab |
| `\\` | backslash |
| `%%` | literal percent sign |
| `''` | literal single quote (inside `' '`) |
| `\r`, `\b`, `\f`, `\v`, `\a` | carriage return, backspace, form feed, vertical tab, alarm |

**Behavior to remember:**
- **Match the code to the type.** `%d`/`%f` for numbers, `%s` for text. Using `%f` on a **string** (`"Sarah"`) → **ERROR**. Using `%s` on a char/number works (with type casting): `%s` on `[65 66 67]` prints `ABC`.
- `fprintf('The output is %d.\n', 42)` → `The output is 42.`
- `fprintf('%f\n', 42)` → `42.000000`
- **Vector/array arguments:** the format **repeats** until all values are consumed. With matrices, MATLAB reads **column-by-column (linear order)**.
  ```matlab
  vec = [6.2 0.11 2.6 5.3];
  fprintf('%.2f  ', vec)   % 6.20  0.11  2.60  5.30
  ```
  For a table of columns x, y, z, build **`tableVals = [x; y; z]`** (stack as rows) then `fprintf('%6.1f%6.1f%6.2f\n', tableVals)`. Using `[x' y' z']` prints in the **wrong order**.

---

## 8. `input`

| Form | Behavior |
|------|----------|
| `n = input("prompt")` | evaluates what the user types as a **numeric** expression → `double` |
| `s = input("prompt", "s")` | stores exactly what was typed as a **char** array (text) |

```matlab
year = input("What year is it?\n");   % e.g. user types 2026 → double 2026
```

---

## 9. VECTORS & THE COLON OPERATOR

**Row vector:** elements separated by spaces or commas: `[78 85 100]` or `[78, 85, 100]` → size `1×n`.
**Column vector:** elements separated by **semicolons**: `[21; 23; 22]` → size `n×1`.

**Colon operator:** `start:step:last`
- Default step is 1: `2:4` → `[2 3 4]` (same as `2:1:4`).
- Reverse with negative step: `4:-1:1` → `[4 3 2 1]`.
- Step won't overshoot `last`: `1:2:6` → `[1 3 5]`.
- Impossible range → **empty** `1×0` vector: `1:-1:10` → `[]`.

**Transpose `'`** flips row↔column: `[2;4;7]'` → `[2 4 7]`.
- The colon operator **cannot directly build a column vector**; make a row then transpose: `(1:3)'`.

**`linspace(x1, x2, n)`** → `n` equally spaced points from `x1` to `x2`: `linspace(0,2,3)` → `[0 1 2]`.

---

## 10. INDEXING  ⭐ (vectors & matrices)

**Indices start at 1.** Use **round brackets** `( )`.

**Vector indexing:** `value = vec(index)`
```matlab
myvec = [5 33 11 -4 2];
myvec(3)        % 11
myvec(end)      % 2   (end = last)
myvec(2:end)    % [33 11 -4 2]
myvec([1 3 5])  % [5 11 2]  (index vector)
myvec(1:2:end)  % [5 11 2]  (every 2nd)
```

**Matrix indexing:** `value = M(rowIndex, colIndex)` — **row first, then column**.
```matlab
myMat = [5 33 11; -4 2 12; 1 47 -15];
myMat(3,2)       % 47
myMat(:,3)       % all rows of column 3  → [11;12;-15]
myMat(2,:)       % all of row 2          → [-4 2 12]
myMat(end,:)     % last row
myMat([1 2],[2 3]) % rows 1-2, cols 2-3  → [33 11; 2 12]
```

**Linear indexing:** one index counts **column-by-column, top to bottom**.
```matlab
mat1 = [1.2 5.7 3.1 7.5;
        3.8 2.2 2.0 4.9;
        4.3 2.8 8.7 9.1];
mat1(2)    % 3.8  (2nd element going down column 1)
mat1(12)   % 9.1  (last element)
mat1(3:5)  % [4.3 5.7 2.2]  (elements 3,4,5 in column order)
```

**Conditional / logical indexing (selecting by condition):**
```matlab
pressure = [100.34 123.65 99.87 96.45 98.89 102.80 110.39 95.21];
lowP = pressure(pressure < 100)   % [99.87 96.45 98.89 95.21]
```
A relational test produces a **logical mask** (same size, of 1s/0s); using it as an index keeps the `true` elements.
- `nitrate(nitrate > limit)` returns the **values** that satisfy the condition.
- When you filter a **matrix** by a condition, the result is **flattened to a column vector** (linear order).

---

## 11. REPLACING / MODIFYING / DELETING ELEMENTS

**Modify:** `variable(index) = expression`
- The assigned value(s) **must match the size** of the targeted subset… **unless** it's a scalar (a scalar fills the whole subset).
```matlab
rvec = 1:5;            % [1 2 3 4 5]
rvec([1 3]) = [0 0];   % [0 2 0 4 5]
rvec(1:3) = 4:6;       % [4 5 6 4 5]
rvec([1 3]) = rvec([3 1]);  % swap → [3 2 1 4 5]

A = [1 2 3;4 5 6;7 8 9];
A(2,3) = 100;              % change one element
A(1:2,2:3) = [20 30;50 60];% block replace (sizes match)
A(1:2,2:3) = 0;            % scalar fills whole block
M(:,1) = [10;10;10];       % replace a whole column
M(2,:) = 1;                % scalar fills entire row 2
```
- **Size mismatch** (e.g. `rvec4(1:2) = [8,7,6]`) → **ERROR**.

**Delete with empty `[ ]`:**
```matlab
v = 2:6;  v(3) = []       % delete element 3 → [2 3 5 6]
m1(2,:) = []              % delete row 2
m1(:,2) = []              % delete column 2
```
- ⚠ You **cannot delete a single element** of a matrix: `m1(2,2) = []` → **ERROR**. (You can only set it: `m1(2,2)=0` or `=NaN`.)

**Empty vector:** `[]` has no elements (used for deletion and for impossible colon ranges).

---

## 12. CONCATENATION

Join arrays by placing them inside `[ ]`. Dimensions must be compatible.
```matlab
rvec  = [1 2];
rvec1 = [rvec 8 9];     % [1 2 8 9]   (horizontal)
rvec2 = [rvec rvec1];   % [1 2 1 2 8 9]
cvec  = [4;5];
cvec2 = [cvec; [6;7]];  % [4;5;6;7]   (vertical)
```
- `rvec(5) = 12` auto-grows a vector, filling gaps with 0: `[1 2 0 0 12]`.
- **Incompatible shapes error:** `[rvec cvec]` (row + column) and `[cvec cvec2]` (2×1 with 4×1) → **ERROR**.
- Matrix rule: **every row must have the same number of values.** `[1 2 3; 4 5]` → **ERROR**.

---

## 13. MATRICES & MATRIX-GENERATION FUNCTIONS

Build manually: rows separated by `;`, values by space/comma. Row construction has higher precedence than column.
```matlab
m1 = [1 2 3; 4 5 6; 7 8 9];   % 3×3
```

**Generator functions:**
| Call | Result |
|------|--------|
| `zeros(n)` / `zeros(n,m)` | n×n / n×m of zeros |
| `ones(n)` / `ones(n,m)` | of ones |
| `eye(n)` | n×n identity (1s on diagonal) |
| `rand(n,m)` | random reals in (0,1) |
| `randi([lo hi], n, m)` | random integers in range |
| `randn(n,m)` | standard-normal randoms |

**3-D arrays:** no single-line syntax — preallocate then fill pages:
```matlab
mat3D = zeros(3,4,2);
mat3D(:,:,1) = mat1;
mat3D(:,:,2) = mat2;
val = mat3D(1,3,2);   % index = (row, col, page)
```

**`reshape(A, sz)`** rearranges elements (filled in **linear/column order**); `prod(sz)` must equal `numel(A)`.
```matlab
vec = 3:14;                 % 12 elements
reshape(vec,[3 4])          % 3×4 matrix
reshape(vec,[2 2 3])        % 2×2×3 array
```

---

## 14. MATRIX MATH & LINEAR ALGEBRA

**Dimensions:**
- `[r,c] = size(M)` → rows & columns. `size(M)` alone → `[r c]`.
- `length(M)` → size of the **longest** dimension.
- `numel(M)` → total number of elements.
- ⚠ Generalize code with `size`/`numel` — don't assume dimensions.

**Element-wise vs. array operators:**
| Element-wise (same-size arrays) | Array / matrix (compatible shapes) |
|---|---|
| `+`  `-`  `.*`  `./`  `.^` | `*` (matrix mult), `\` (left divide), `/`, `'` (transpose) |

- The **dot** forces element-by-element: `a.*b`, `a./b`, `a.^2`.
- Element-wise needs **equal shapes** (or one scalar). `[1 2 3] + [4 5]` → **ERROR**.
- A scalar applies to every element: `m1 + 3`, `m1 * 3`.

**Matrix multiplication `*`:** inner dimensions must match. `(m×n)*(n×p)` → `(m×p)`.
- Row × column = **dot product** (scalar): `[6 0 2 5]*[9;4;8;1]` = `75`.
- Column × row = **outer product** (matrix): `(4×1)*(1×4)` → 4×4.
- column × column with `*` → **ERROR** (use `cvec1'*cvec2` for the dot product, or `.*` for element-wise).
- Dimension mismatch → **ERROR** ("Incorrect dimensions for matrix multiplication").

**Transpose:** `A'` swaps rows and columns.

**Determinant:** `det(A)` (square matrices). For 2×2 `[a b; c d]` → `ad − bc`.

**Inverse:** `inv(A)` or `A^-1`. Exists only if A is **square and non-singular** (`det(A) ≠ 0`).

**Solving a linear system `A*x = b`:** use **left divide `x = A\b`** (preferred — more accurate/efficient than `inv(A)*b`).
```matlab
A = [2 5; 3 -2];  b = [11; -12];
x = A\b;          % [-2; 3]   solves 2x+5y=11, 3x-2y=-12
```

**Dimension-direction argument** for reductions on matrices:
- `sum(A)` / `sum(A,1)` → sum **down each column** (default). `sum(A,2)` → sum **across each row**.
- Same pattern for `mean`, `median`, `std`, `min`, `max` (note the placeholder: `min(A,[],2)`, `max(A,[],2)`, `std(A,0,2)`).
- `sum(A,'all')` adds **every** element (used to count exceedances in a logical matrix).

**Vector/array stat functions:**
| Function | Returns |
|----------|---------|
| `sum(A)` | sum of elements |
| `mean(A)` | average |
| `median(A)` | median |
| `std(A)` | standard deviation (N−1 normalized) |
| `min(A)` / `max(A)` | smallest / largest |
| `[val, ind] = max(A)` | value **and its index** (same for `min`) |
| `length(A)` | number of elements |

---

## 15. SORTING & FILTERING DATA

**`sort(x)`** — ascending by default:
```matlab
x = [7 2 9 4];
sort(x)              % [2 4 7 9]
sort(x,'descend')    % [9 7 4 2]
[y, order] = sort(x) % y=[2 4 7 9], order=[2 4 1 3] (original positions)
```
- `[~, ind] = sort(x)` uses `~` to discard the sorted values and keep only the index list.

**`sortrows(data, col, 'descend')`** sorts whole **rows** by the values in one column (keeps each row intact). Great for data tables.

**Filtering rows by condition:**
```matlab
idx = data(:,3) > 100;       % logical mask on column 3
highChloride = data(idx,:);  % keep rows where condition is true
```

**`find()`** returns the **indices** (locations) where a condition is true — *not* the values:
```matlab
midterm = [55 99 85 40 45 93 84 39];
find(midterm == 93)   % 6
find(midterm < 50)    % [4 5 8]
find(midterm == 100)  % []  (empty: no matches)
```
- Logical mask vs `find`: mask is a same-size 0/1 array; `find` gives a (usually shorter) list of indices.
- Count matches: `sum(mask)` **or** `length(find(...))`.

---

## 16. STRINGS, CHAR VECTORS & STRING OPERATIONS

**Three text things — know the difference:**
| Thing | Quotes | Class | Size of `'MATLAB'`/`"MATLAB"` | Index a letter? |
|-------|--------|-------|-------------------------------|-----------------|
| character | `'A'` | char | 1×1 | — |
| **char vector** | `'MATLAB'` | char | 1×6 (each letter is an element) | YES `cv(3)`→`'T'` |
| **string** | `"MATLAB"` | string | 1×1 (one unit) | NO → `sv(3)` is ERROR* |

\*`"MATLAB"(3)` errors because a string scalar is a single element; `numel("MATLAB")` = 1, while `numel('MATLAB')` = 6.

**Char-vector operations (indexable like numeric arrays):**
```matlab
charVec = 'MATLAB';
numel(charVec)        % 6
charVec(3)            % 'T'
charVec(1:3)          % 'MAT'
[charVec ' is fun.']  % 'MATLAB is fun.'  (concatenate with [ ])
```

**String operations:**
```matlab
strVec = "MATLAB";
numel(strVec)              % 1
strVec + " is fun."        % "MATLAB is fun."  (concatenate with +)
[s1; s2; s3]               % build a string array (column)
```

**Comparing text:**
- **Char vectors** of **equal length**: `==` compares letter-by-letter → logical vector.
  `'Brad' == 'Fred'` → `[0 1 0 1]`.
  Different lengths with `==` → **ERROR** (`'Bob' == 'Elizabeth'`).
- **Whole-phrase** comparison: `strcmp(a,b)` returns a single `1`/`0` and works for **any** lengths (`strcmp('Bob','Elizabeth')` → 0).
- For strings, `==` does a whole-phrase comparison: `string('Bob')==string('Elizabeth')` → 0 (no error).

**Search & replace:**
| Function | Does | Example → result |
|----------|------|------------------|
| `strfind(phrase, sub)` | start index(es) of substring | `strfind('...exam?','exam')` → 21; multiple → `[1 14 18]`; none → `[]` |
| `strrep(phrase, old, new)` | find-and-replace (**case-sensitive**) | `strrep('I enjoy golf','golf','calculus')` → `'I enjoy calculus'` |

**Other text helpers:**
| Function | Returns | Example |
|----------|---------|---------|
| `sort(strArray)` | alphabetical order | sorts `["Hi";"Class";...]` |
| `upper(p)` / `lower(p)` | all upper / lower case | `upper('hi!')`→`'HI!'` |
| `isspace(c)` | logical: 1 where space | `isspace('Hi You')` → `[0 0 1 0 0 0]` |
| `isletter(c)` | logical: 1 where a letter | `isletter('Hi!')` → `[1 1 0]` |
| `char(v1,v2,...)` | char **matrix**, pads shorter rows with spaces | `char('Helena','Amy')` → 2×6 |

⚠ `[n1; n2; n3]` with **unequal-length char vectors** → **ERROR** (use `char(...)` to pad). Strings of unequal length **can** stack: `["Lettuce";"Corn"]` is fine.

---

## 17. STATEMENTS THAT PRODUCE AN **ERROR** (memorize — you'll write `ERROR`)

- Referencing an **undefined variable** (wrong case counts): `fprintf('%d', Mass)` when only `mass` exists.
- **Index ≤ 0, non-integer, or negative:** `v(0)`, `v(-1)`, `v(2.5)` → *"Array indices must be positive integers or logical values."*
- **Index past the end:** `v(10)` on a length-8 vector → *"Index exceeds the number of array elements."*
- **Element-wise op on mismatched sizes:** `[1 2 3] + [4 5]`.
- **Matrix mult with mismatched inner dims:** `[1 2 3]*[4 5]`, or column `*` column.
- **Assignment size mismatch:** `rvec(1:2) = [8 7 6]`.
- **Concatenating incompatible shapes:** `[rowVec colVec]`, `[1 2 3; 4 5]`, stacking unequal-length **char** vectors.
- **Deleting a single matrix element:** `M(2,2) = []`.
- **Comparing unequal-length char vectors with `==`:** `'Bob' == 'Elizabeth'`.
- **Indexing into a string scalar:** `"MATLAB"(3)`, `"MATLAB"(1:3)`.
- **Wrong format type:** `fprintf('%f', "Sarah")` (numeric code on a string).

*Things that are legal (NOT errors), even if odd:* overwriting `pi`/`sum`; chained relations like `2<4<3`; `log(0)` → `-Inf`; `log(-5)` → complex; auto-growing a vector via `v(5)=12`.

---

## 18. WORKED ENGINEERING EXAMPLES (the quiz favors these contexts)

**(A) Water quality after treatment — element-wise + logical + find:**
```matlab
C       = [14.0 0.30; 9.0 0.18; 16.0 0.12];   % rows=locations, cols=[nitrate phosphate]
removal = [25 40; 20 30; 35 20];              % percent removed
limit   = [10 0.15; 10 0.15; 10 0.15];

Cfinal = C .* (1 - removal/100);   % concentration remaining
avgNitrate   = mean(Cfinal(:,1));  % column 1 = nitrate
avgPhosphate = mean(Cfinal(:,2));
exceed = Cfinal > limit;           % logical matrix
numExceed = sum(exceed,'all');     % count of values over limit
locs = find(Cfinal(:,1) > 10);     % which locations' nitrate > 10
```

**(B) Groundwater inflow — solving a linear system:**
```matlab
% 2q1+q2+q3=13 ; q1+3q2+2q3=18 ; q1+q3=7
A = [2 1 1; 1 3 2; 1 0 1];
b = [13; 18; 7];
detA = det(A);
q = A\b;                  % solve for [q1;q2;q3]
high = find(q > 4);       % fractures with inflow > 4 L/min
total = sum(q);
```

**(C) Daily pollutant load (MATLAB as a program, not a calculator):**
```matlab
Q = 0.25;          % m^3/s
C = 35;            % mg/L
mgL2kgm3 = 0.001;  sec2day = 86400;
load = Q*C*mgL2kgm3*sec2day;   % 756 kg/day
```

**(D) Vertical stress in rock:** `stress = density*g*depth/1000;` with density=2100, g=9.81, depth=25 → **515.025 kPa**.

**(E) Groups remainder:** `rem(numStudents,2/3/4)` gives students left over; `floor(n/4)` gives number of full groups.

---

## 19. RAPID-FIRE OUTPUT-PREDICTION DRILLS (cover the answers!)

| # | Expression | Answer |
|---|------------|--------|
| 1 | `2 * -3 ^ 3 + 4` | **−50** |
| 2 | `~(5 ~= 10 / 2)` | **1** (true) |
| 3 | `2 < 4 < 3` | **1** (`(2<4)=1`, `1<3=1`) |
| 4 | `'A' + 5 - 'B'` | **4** (65+5−66) |
| 5 | `int16((str2num('12') * 3 - 6) / 4)` | **8** ((36−6)/4 = 7.5 → rounds to 8) |
| 6 | `-10^2` | **−100** |
| 7 | `10^(2+3)` | **100000** |
| 8 | `double('9')` | **57** |
| 9 | `char(65)` | **'A'** |
| 10 | `rem(9,5)` | **4** |
| 11 | `floor(-0.3)` / `fix(-0.3)` / `ceil(-0.3)` / `round(-0.3)` | **−1 / 0 / 0 / 0** |
| 12 | `(1:2:6)` | **[1 3 5]** |
| 13 | `(4:-1:1)` | **[4 3 2 1]** |
| 14 | `1:-1:10` | **[]** (empty) |
| 15 | `v=[5 33 11 -4 2]; v(end-1)` | **−4** |
| 16 | `sort([7 2 9 4],'descend')` | **[9 7 4 2]** |
| 17 | `find([55 99 85 40] < 50)` | **4** |
| 18 | `'Brad' == 'Fred'` | **[0 1 0 1]** |
| 19 | `strcmp('Bob','Elizabeth')` | **0** |
| 20 | `numel("MATLAB")` vs `numel('MATLAB')` | **1** vs **6** |
| 21 | `[1 2 3] .* [4 5 6]` | **[4 10 18]** |
| 22 | `[6 0 2 5]*[9;4;8;1]` | **75** |
| 23 | `sum([1 2 3;4 5 6])` | **[5 7 9]** (down columns) |
| 24 | `sum([1 2 3;4 5 6],2)` | **[6;15]** (across rows) |
| 25 | `class(true + 3)` | **double** (value 4) |

---

## FINAL CHECKLIST BEFORE THE QUIZ
- [ ] Recite the **precedence order** without looking.
- [ ] Know **1-based indexing**, `end`, `:` for whole rows/columns, and **linear (column-wise)** order.
- [ ] Know every situation that throws **ERROR** (Section 17).
- [ ] `double('c')` = ASCII; `str2num`/`num2str` = face value.
- [ ] `&&`/`||` for scalars (and `if`); `&`/`|` for arrays.
- [ ] Trig is in **radians**; `log` is **natural log**.
- [ ] `A\b` solves systems; `det`/`inv` need square (non-singular).
- [ ] `find` returns **indices**; `mask` returns **0/1**; `M(M>k)` returns **values** (flattened to a column).
- [ ] Char vectors are indexable & compare with `==` (equal length only); strings are single units & use `strcmp`/`==` whole-phrase.
- [ ] Match `fprintf` codes to types; vectors make the format **repeat**; stack table data as **rows** `[x;y;z]`.

Good luck — you've got this!
