% Adam Farah: 100966918
%
% The family in this database only go up to grandparents
% nevertheless, it still works for all cases of ancestry
%
% Excluding the main mother, father and their children,
% all other relatives (aunts,uncles and grandparents)
% share the same name.
% They are noted by '_f' and '_m' as to which sides
% of the family their ancestry belong too (Frank or Martha)
%
% Comments in 'rules of relations' that specify roles as
% the processes run (mother father..ext) directly relate to
% this own database. Not the one a TA may test on.
%
%-------------------------------------------------
% ALL FAMILY MEMEBERS
%
% son - sam
% daughter - denise
%
% father - frank
% mother - martha
%
% uncle - ugo_f and ugo_m
% aunt - annie_f and annie_m
%
% grandfather - gary_f and gary_m
% grandmother - gertrude_f and gertrude_m
% ------------------------------------------------
%

%----------------------------BOTH SIDES OF FAMILES MALE----------------------------
male(sam).
%brother of denise
%son of frank and martha
%nephew of ugo_f, annie_f, ugo_m, annie_m
%granson of gertrude_f , gary_f , gertrude_m , gary_m

male(frank).
%husband of martha
%father of sam and denise
%brother of annie_f & ugo_f
%son of gertrude_f & gary_f

male(ugo_f).
%uncle of sam and denise
%brother of frank and annie_f
%son of gertrude_f & gary_f

male(ugo_m).
%uncle of sam and denise
%brother of martha and annie_m
%son of gertrude_m & gary_m

male(gary_f).
%husband of gertrude_f
%father of frank, ugo_f, annie_f
%grandfather of sam and denise

male(gary_m).
%husband of gertrude_m
%father of martha, ugo_m, annie_m
%grandfather of sam and denise

%----------------------------BOTH SIDES OF FAMILIES FEMALE--------------------------
female(denise).
%sister of sam
%daughter of frank and martha
%neice of ugo_f, annie_f, ugo_m, annie_m
%grandaughter of gertrude_f , gary_f , gertrude_m , gary_m

female(martha).
%wife of frank
%mother of sam and denise
%sister of annie_m & ugo_m
%daughter of gertrude_m & gary_m

female(annie_f).
%sister of frank and ugo_f
%aunt of sam and denise
%daughter of gertrude_f & gary_f

female(annie_m).
%sister of martha and ugo_m
%aunt of sam and denise
%daughter of gertrude_m & gary_m

female(gertrude_f).
%wife of gary_f
%mother of frank, ugo_f, annie_f
%grandmother of sam and denise

female(gertrude_m).
%wife of gary_m
%mother of martha, ugo_m, annie_m
%grandmother of sam and denise

%__________________________________________________________________________________________


%frank is the father of sam and denise
father(frank, sam).
father(frank, denise).
%gary_f is the father of frank, ugo_f, annie_f
father(gary_f, frank).
father(gary_f, ugo_f).
father(gary_f, annie_f).
%gary_m is the father of martha, ugo_m, annie_m
father(gary_m, martha).
father(gary_m, ugo_m).
father(gary_m, annie_m).


%martha is the mother of sam and denise
mother(martha, sam).
mother(martha, denise).
%gertrude_f is the mother of frank, ugo_f, annie_f
mother(gertrude_f, frank).
mother(gertrude_f, ugo_f).
mother(gertrude_f, annie_f).
%gertrude_m is the mother of martha, ugo_m, annie_m
mother(gertrude_m, martha).
mother(gertrude_m, ugo_m).
mother(gertrude_m, annie_m).

%frank is married to martha and gary is married to gertrude
married(frank,martha).
married(gary_f, gertrude_f).
married(gary_m, gertrude_m).

%__________________________________________________________________________________________


%RULES OF RELATIONS
%
parent(X,Y):-
	male(X), father(X,Y); %X male and is a father to Y or
	female(X), mother(X,Y).%X is female and is a mother to Y


different(X,Y):- not(X = Y). %X and Y are not the same value


is_mother(X):-
	female(X),   %X is female and
	parent(X,_). %X is a parent of some child

is_father(X):-
	male(X),
	parent(X,_).


aunt(X, Y):-
	female(X),
	parent(W,X), %X is a child of persone W (grandparent) and
	parent(W,Z), %persone W is a parent of persone Z (mother or father) and
	parent(Z,Y)  %persone Z is a parent of Y (son or daughter)
.
uncle(X, Y):-
	male(X),
	parent(W,X),
	parent(W,Z),
	parent(Z,Y).



sister(X,Y):-
	female(X),
	parent(W,X), %there is a persone W that is the parent of X and
	parent(W,Y). %is also a parent of Y

brother(X,Y):-
	male(X),
	parent(W,X),
	parent(W,Y).



grandfather(X,Y):-
	male(X),
	parent(X,W), %X is a parent of a persone W and
	parent(W,Y). %W is also the parent of Y

grandmother(X,Y):-
	female(X),
	parent(X,W),
	parent(W,Y).



ancestor(X,Y):-
	parent(X,Y); %initial check for father/mother and son/daughter case
	parent(X,W), ancestor(W,Y). %X is the parent a person W and will call again with persone W and Y
                                    %persone W will be unified as the one down the lineage
				    %ex: if originally calling ancestor(great-grandfather_f,sam). (for some great-grandfather value)
				    %parent(great-granfather_f,W) will unify to parent(gary_f,sam)
				    %now left with the sub goal of ancestor(gary_f,sam)

%__________________________________________________________________________________________
%TEST
% Call at terminal for each test corresponding to each relation with the
% frank and martha database.

%PARENT
frankparent:-
	display("parent relastions- frank and sam"),nl,
	display("?-parent(frank,sam)."),nl,
	display("Expected, true"),nl,
	parent(frank,sam). %actual


gary_f_parent:-
	display("parent relastions- gary_f and ugo_m"),nl,
	display("?-parent(gary_f, ugo_m)."),nl,
	display("Expected, false"),nl,
	parent(gary_f,ugo_m). %actual

%-----
%DIFFERENT
different1:-
	display("different- sam and denise"),nl,
	display("?-different(sam,denise)."),nl,
	display("Expected, true"),nl,
	different(sam,denise). %actual

different2:-
	display("different- denise and denise"),nl,
	display("?-different(sam,sam)."),nl,
	display("Expected, false"),nl,
	different(denise,denise). %actual

%-----
%IS_MOTHER
is_mother1:-
	display("is_mother test- gertrude_f"),nl,
	display("?-is_mother(gertrude_f)."),nl,
	display("Expected, true"),nl,
	is_mother(gertrude_f). %actual

is_mother2:-
	display("is_mother test- denise"),nl,
	display("?-is_mother(denise)."),nl,
	display("Expected, false"),nl,
	is_mother(denise). %actual

%-----
%UNCLE
uncle1:-
	display("uncle test- ugo_m and denise"),nl,
	display("?-uncle(ugo.m,denise)."),nl,
	display("Expected, true"),nl,
	uncle(ugo_m,denise). %actual

uncle2:-
	display("uncle test- gary_m and frank"),nl,
	display("?-uncle(gary.m,frank)."),nl,
	display("Expected, false"),nl,
	uncle(gary_m,frank). %actual

%-----
%SISTER
sister1:-
	display("sister test- annie_f and frank"),nl,
	display("?-sister(annie_f,frank)."),nl,
	display("Expected, true"),nl,
	sister(annie_f,frank). %actual

sister2:-
	display("sister test- sam and denise"),nl,
	display("?-sister(sam,denise)."),nl,
	display("Expected, false"),nl,
	sister(sam,denise). %actual


%-----
%GRANDMOTHER
grandmother1:-
	display("grandmother test- gertrude_m sam"),nl,
	display("?-grandmother(gertrude_m,sam)."),nl,
	display("Expected, true"),nl,
	grandmother(gertrude_m,sam). %actual

grandmother2:-
	display("grandmother test- annie_f, martha"),nl,
	display("?-grandmother(annie_f,martha)."),nl,
	display("Expected, false"),nl,
	grandmother(annie_f,martha). %actual



%-----
%ANCESTOR
ancestor1:-
	display("ancestorTest- gary_m and denise"),nl,
	display("?-ancestore(gary_m,denise)."),nl,
	display("Expected, true"),nl,
	ancestor(gary_m,denise). %actual

ancestor2:-
	display("ancestorTest- denise and annie_f"),nl,
	display("?-ancestor(denise,annie_f)."),nl,
	display("Expected, false"),nl,
	ancestor(denise,annie_f). %actual








