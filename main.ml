
let help = 
"help
create [title] [content]
delete [id]
list
read [id]
edit [id]"

let extracted_args inp = Str.split (Str.regexp " ") inp

let rec todo () =
  print_string "\nWelcome to the todo list: ";
  let inp = read_line() in
    let args = extracted_args inp in
      let command = List.nth args 0 in
          match command with
          | "help" -> print_string help; todo ()
          | "create" -> 
            let oc = open_out (Printf.sprintf "notes/%s.txt" (List.nth args 1))  in
            Printf.fprintf oc "%s\n" (List.nth args 2);
            close_out oc;
          | "delete" -> todo ()
          | "list" -> todo ()
          | "read" -> todo ()
          | "edit" -> todo ()
          | "quit" | "exit" -> ()
          | _ ->
              print_string "Could find command, type 'help' for all commands";
              todo ();;

todo ()
