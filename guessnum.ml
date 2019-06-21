let () =
  Random.self_init();
  let n =
    if Random.bool () then
      let n = 2 + Random.int ((int_of_string Sys.argv.(1)) - 2) in
      Printf.printf "Please guess a number between 1 and %s excluded \n" Sys.argv.(1);
      (n)
    else
      let n = 1 + Random.int (int_of_string Sys.argv.(1)) in
      Printf.printf "Please guess a number between 1 and %s included \n" Sys.argv.(1);
      (n)
  in
  while read_int () <> n do
    if read_int() = n + 2 && n + 2 <= (int_of_string Sys.argv.(1)) then 
            print_endline "You're warmer!"
    else if read_int() = (n - 2) && (n - 2) > 0 then 
            print_endline "You're warmer!"
    else 
        begin
            print_endline "You're colder!"
        end;
    print_endline "The guess was wrong! Please try again!";
  done;
  print_endline "Well guessed!";
