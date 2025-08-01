### Returns the cyclic group of order n as a permutation group (for easy access)
C := function(n)
    return CyclicGroup(IsPermGroup, n);
end;



### Constructs the abstract holomorph of a group G
### The abstract holomorph is the semidirect product of Aut(G) and G
abstractHolomorph := function(G)
    return SemidirectProduct(AutomorphismGroup(G), G);
end;



### Constructs the permutational holomorph of a group G
### This is defined as the normalizer of the regular representation of G in a symmetric group
permutationalHolomorph := function(G)
    local rho, B, Hol;

    # Right regular representation of G on itself
    rho := Action(G, AsList(G), OnRight);

    # Symmetric group on the maximum moved point by rho
    B := SymmetricGroup(LargestMovedPoint(rho));

    # Normalizer of the image of G in the symmetric group
    Hol := Normalizer(B, rho);

    return Hol;
end;



### Computes all regular subgroups of the permutational holomorph of G
### A subgroup is regular if it acts regularly on [1..|G|]
allRegularSubgroupsHolomorph := function(G)
    local H, L, CC, i, j, reg;

    # Compute the permutational holomorph
    H := permutationalHolomorph(G);

    # Build the subgroup lattice and extract conjugacy classes of subgroups
    L := LatticeSubgroups(H);
    CC := ConjugacyClassesSubgroups(L);

    reg := [];

    # Collect all subgroups from the conjugacy classes
    for i in [1..Size(CC)] do
        for j in [1..Size(CC[i])] do
            Add(reg, CC[i][j]);
        od;
    od;

    # Filter only the regular subgroups
    reg := Filtered(reg, x -> IsRegular(x, [1..Size(G)]));

    return reg;
end;



### Maps a string (or any input convertible to string) to a color represented by RGB triplet
stringToColor := function(v)
    local s, n, m, r, c1, c2, c3;

    # Define numeric bounds
    n := 1000000000;
    m := 99999999;

    # Convert string to a large integer hash
    s := AbsInt(CrcString(String(v)));

    # Ensure the number is sufficiently large
    while (s < m) do
        s := s * 777 + 1;
    od;

    # Normalize the number under the limit n
    while (s >= n) do
        r := RemInt(s, n);
        s := QuoInt(s - r, n) + r;
    od;

    # Extract RGB components by slicing digits
    c1 := RemInt(s, 1000);
    c2 := QuoInt(RemInt(s, 1000000) - RemInt(s, 1000), 1000);
    c3 := QuoInt(s - QuoInt(RemInt(s, 1000000) - RemInt(s, 1000), 1000), 1000000);

    # Reduce values to [0,255] range
    c1 := RemInt(c1, 256);
    c2 := RemInt(c2, 256);
    c3 := RemInt(c3, 256);

    return [c3, c2, c1];  # Return RGB color
end;



### Writes a Python program that plots a graph using NetworkX and matplotlib
### The graph is defined by a vertex/edge list and filtered for color assignment
networkXFiltered := function(graph,filt)

	local vert, edges, file, i;

	### Extract vertices and edges
	vert := graph[1];
	edges := graph[2];
	edges := Filtered(edges, e -> e[1] <> e[2]);


	### Create/Overwrite a file in the currect directory and initialize it
	file := Filename(DirectoryCurrent(), "NEOgraph.py");
	PrintTo(file, "");

	### Print header in python code
	AppendTo(file, "import matplotlib.pyplot as plt\n");
	AppendTo(file, "import networkx as nx\n");
	AppendTo(file, "import numpy as np\n\n");
	AppendTo(file, "fig, ax = plt.subplots()\n");
	AppendTo(file, "fig.canvas.manager.set_window_title('Normalizing Graph')\n\n");
	AppendTo(file, "G = nx.Graph()\n\n");


	### Print nodes code
	AppendTo(file, Concatenation("G.add_nodes_from([1,",String(Length(vert)), "])\n\n"));


	### Print edges code
	for i in [1..Length(edges)] do
		AppendTo(file, Concatenation("G.add_edge(",String(edges[i][1]), ",", String(edges[i][2]), ", minlen = 2)\n"));
	od;


	### Filtering & colouring
	AppendTo(file, "\n\n");
	AppendTo(file, "color_map = []\n\n");

	for i in [1..Length(filt)] do
		AppendTo(file, Concatenation("color_map.append('#%02x%02x%02x' % (", String(filt[i][1]), ",", String(filt[i][2]), ",", String(filt[i][3]), ")) # ", String(i), "\n"));
	od;


	### Technical exchange of values due to syntaxical differences among GAP and Python
	AppendTo(file, Concatenation("\ncolor_map[0], color_map[",String(Length(filt)-1),"] = color_map[",String(Length(filt)-1),"], color_map[0]"));


	### Print the last lines of python code
	AppendTo(file, "\ncolor_map = np.roll(color_map,1)\n");
	AppendTo(file, "\nplt.title(r'Normalizing Graph')\n");
	AppendTo(file, "\npos = nx.spring_layout(G)\n");
	AppendTo(file, "nx.draw(G,\n with_labels = True,\n font_color = 'white',\n font_size =  10,\n font_weight = 'bold',\n node_size = 200,\n node_color = color_map)\n");
	AppendTo(file, "plt.show()");

end;



### Constructs and displays the normalizing graph of regular subgroups of the holomorph of G
### Two subgroups are adjacent if they normalize each other
NEO := function(G)

	local H, A, B, reg, verts, edges, filt;


	### Initialize graph and filter
	verts := [];
	edges := [];
	filt := [];


	### Construction of the permutational holomorph
	H := permutationalHolomorph(G);


	### Extraction of all rhe regular subgroups
	reg := allRegularSubgroupsHolomorph(G);


	### Construction of the normalizing graph as GAP list
	for A in reg do
		for B in reg do

			if (IsNormal(A,B) and IsNormal(B,A)) then
				if not (A in verts) then
					Add(verts,A);
				fi;

				if not (B in verts) then
					Add(verts,B);
				fi;

				if not ([Position(verts,A), Position(verts,B)]) in edges then
					Add(edges,[Position(verts,A), Position(verts,B)]);
				fi;

				if not ([Position(verts,B), Position(verts,A)]) in edges then
					Add(edges,[Position(verts,B), Position(verts,A)]);
				fi;

			fi;
		od;
	od;


	### Filtering & colouring
	for A in verts do
		Append(filt,[stringToColor(IdGroup(A))]);
	od;


	### Construction of the normalizing graph as NetworkX image
	networkXFiltered([verts,edges],filt);


	### Display the graph in background
	Exec("python NEOgraph.py &");


	### Output of the regular subgroups
	return verts;

end;



### Computes the gamma function of a regular subgroup N of the holomorph of G
### Each entry is a triple: [g in G, nu(g) in N, gamma(g) = nu(g) * g^(-1)]
gammaFunction := function(G, N)
    local elemG, elemN, list, x, rhoG, gamma;

    # Right regular representation of G
    rhoG := Action(G, AsList(G), OnRight);

    # Elements of G and N as permutations
    elemG := Elements(rhoG);
    elemN := ShallowCopy(Elements(N));

    # Sort elemN according to their action on 1
    list := List(elemN, x -> 1^x);
    SortParallel(list, elemN);

    gamma := [];

    # Build the list of triples [g, nu(g), gamma(g)]
    for x in [1..Size(G)] do
        Add(gamma, [list[x]-1, elemN[x], elemN[x] * elemG[x]^(-1)]);
    od;

    return gamma;
end;



### Evaluates gamma(x): returns the third component for given x in G
gammaEvaluate := function(gamma, x)
    local i;

    for i in [1..Length(gamma)] do
        if gamma[i][1] = x then
            return gamma[i][3];
        fi;
    od;

    return fail;
end;



### Evaluates nu(x): returns the second component for given x in G
nuEvaluate := function(gamma, x)
    local i;

    for i in [1..Length(gamma)] do
        if gamma[i][1] = x then
            return gamma[i][2];
        fi;
    od;

    return fail;
end;



### Displays the gamma function in a readable table format
### Shows: x in G  →  corresponding automorphism in Aut(G)
gammaDisplay := function(gamma)
    local x, n;

    n := gamma[Length(gamma)][1];

    Print("Z/", n+1, "Z   |   Aut(G)\n\n");

    for x in [0..n] do
        Print("  ", x, "       x -> x^", String(2^gammaEvaluate(gamma, x) - 1), "\n");
    od;

    Print("\n");
end;



### Returns the image set of gamma: { gamma(g) | g in G }
gammaImage := function(gamma)
    local i, res;

    res := [];

    for i in [1..Length(gamma)] do
        Add(res, gamma[i][3]);
    od;

    return AsSet(res);
end;



### Returns the set of all preimages of a given element a under gamma
gammaPreimage := function(gamma, a)
    local i, res;

    res := [];

    for i in [1..Length(gamma)] do
        if gamma[i][3] = a then
            Add(res, gamma[i][1]);
        fi;
    od;

    return AsSet(res);
end;



### Returns the kernel of gamma: { g in G | gamma(g) = identity }
gammaKernel := function(gamma)
    local i, res;

    res := [];

    for i in [1..Length(gamma)] do
        if gamma[i][3] = () then
            Add(res, gamma[i][1]);
        fi;
    od;

    return AsSet(res);
end;



### Computes the circle operation: x ∘ y := nu(y)(x), minus 1 to adjust to GAP indexing
circ := function(G, gamma, x, y)
    local i, j;

    i := x + 1;                             # Adjust for 1-based indexing
    j := nuEvaluate(gamma, y);              # Retrieve nu(y)

    return i^j - 1;                         # Compute nu(y)(x+1) and adjust back
end;



### Computes x∘x∘...∘x (n times) using the circ operation
circPower := function(G, gamma, x, n)
    local res, i;

    res := x;

    for i in [1..n-1] do
        res := circ(G, gamma, res, x);
    od;

    return res;
end;



### Computes all powers of x under circ, from 0 up to Size(G)
circPowers := function(G, gamma, x)
    local res, i;

    res := [];
    Add(res, 0);        # Identity element under circ

    for i in [1..Size(G)] do
        Add(res, circPower(G, gamma, x, i));
    od;

    return res;
end;



### Computes the inverse of x under the circ operation: x∘y = 0
circInverse := function(G, gamma, x)
    local y, res;

    for y in [0..Size(G)-1] do
        if circ(G, gamma, x, y) = 0 then
            res := y;
        fi;
    od;

    return res;
end;



### Computes the order of each element in G under the circ operation
circOrders := function(G, gamma)
    local x, y, ord, res;

    res := [];
    ord := 1;

    for x in [0..Size(G)-1] do
        y := ShallowCopy(x);

        while not y = 0 do
            y := circ(G, gamma, y, x);
            ord := ord + 1;
        od;

        Add(res, [x, ord]);
        ord := 1;
    od;

    return res;
end;



### Displays the Cayley table of (G, ∘) where ∘ is the circle operation
circTable := function(G, gamma)
    local row, tab, x, y;

    row := [];
    tab := [];

    Print("\n   ");
    for x in [0..Size(G)-1] do
        Print(x, " ");
    od;

    Print("\n\n");

    for x in [0..Size(G)-1] do
        Print(x, "  ");

        for y in [0..Size(G)-1] do
            Add(row, circ(G, gamma, x, y));
            Print(circ(G, gamma, x, y), " ");
        od;

        Add(tab, row);
        row := [];
        Print("\n");
    od;

    Print("\n");
end;

### Returns the modular inverse of x mod n, if it exists
modInverse := function(x, n)
    local res, y;

    res := fail;

    for y in [0..n-1] do
        if RemInt(x * y, n) = 1 then
            res := y;
        fi;
    od;

    return res;
end;



### Returns the smallest positive representative of x mod n
positiveRem := function(x, n)
    if RemInt(x, n) >= 0 then
        return RemInt(x, n);
    else
        return RemInt(x, n) + n;
    fi;
end;



### Checks a theorem on mutual normalization between two regular subgroups N and M
### Verifies a compatibility condition involving gamma functions of N and M
mutualGamma := function(G, N, M)
    local check, gamma, delta, g, h, op1, op2;

    gamma := gammaFunction(G, N);
    delta := gammaFunction(G, M);

    check := true;

    for g in [0..Size(G)-1] do
        for h in [0..Size(G)-1] do

            op1 := positiveRem(circ(G, delta, h, g) - circ(G, gamma, g, h) + h, Size(G));
            op2 := positiveRem(circ(G, gamma, h, g) - circ(G, delta, g, h) + h, Size(G));

            if not (gammaEvaluate(gamma, h) = gammaEvaluate(gamma, op1) and
                    gammaEvaluate(delta, h) = gammaEvaluate(delta, op2)) then
                check := false;
            fi;
        od;
    od;

    return check;
end;