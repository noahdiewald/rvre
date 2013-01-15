-module(rvre_tests).

-include_lib("eunit/include/eunit.hrl").

ascii_char_class_test_() ->
    {"Ascii Character Class Tests",
     [{"Recognize a Class",
       ?_assertMatch({_,{_,{{_,[_,{char_class,[{ascii,upper}]},_]},_}}}, rvre:parse("^[[:upper:]]$"))},
      {"Recognize a Class Complement", 
       ?_assertMatch({_,{_,{{_,[_,{char_class,[{ascii,comp_upper}]},_]},_}}}, rvre:parse("^[[:^upper:]]$"))},
      {"Both Complements are Equivalent", 
       ?_assertEqual(rvre:compile("[^[:upper:]]"), rvre:compile("[[:^upper:]]"))},
      {"Both Complements are Equivalent", 
       ?_assertEqual(rvre:compile("[^[:cntrl:]]"), rvre:compile("[[:^cntrl:]]"))}
     ]}.

low_complement_ranges_test_()->
    {"Complements of Ranges Starting With Zero",
     [{"A Series of Ranges",
       ?_assertEqual([{32,57},{68,maxchar}],rvre:comp_cc([{0,31},{58,67}]))},
      {"A Range Followed by a Single Number",
       ?_assertEqual([{32,57},{59,maxchar}],rvre:comp_cc([{0,31},58]))},
      {"A Single Number Followed by a Range",
       ?_assertEqual([{1,57},{68,maxchar}],rvre:comp_cc([0,{58,67}]))},
      {"A Single Number Followed by a Single Number",
       ?_assertEqual([{1,57},{59,maxchar}],rvre:comp_cc([0,58]))}
     ]}.
