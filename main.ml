let help =
"help
create [title] [content]
delete [title]
list
read [title]
edit [title]"

let extracted_args inp = Str.split (Str.regexp " ") inp



let rec todo () =
  print_string "\nWelcome to the todo list: ";
  let inp = read_line() in
    let args = extracted_args inp in
      let command = List.nth args 0 in
          match command with
          | "help" -> print_string help; todo ()
          | "create" -> 
            let filename = (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in
            if not (Sys.file_exists filename) then
              let oc = open_out (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in
                Printf.fprintf oc "%s\n" (List.nth (Str.bounded_split (Str.regexp " ") inp 3) 2);
                close_out oc;
                print_string "File created";
                todo ()
            else
              print_string "File already exists";
              todo ()
          | "delete" ->
            let filename = (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in
              if Sys.file_exists filename then
                let () = Sys.remove filename in
                print_string "File deleted";
                todo ()
              else
                print_string "File doesn't exist";
                todo ()
          | "list" ->
            let files = Sys.readdir "notes" in
              let notes = List.filter (fun file -> Str.last_chars file 4 = ".txt") in
                let notes_string = String.concat "\n" notes in
                  Printf.printf notes_string
          | "read" -> 
            let ic = open_in (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in
            let line = input_line ic in
              print_endline line;
              flush stdout;
              close_in_noerr ic;
              todo ()
          | "edit" -> todo ()
          | "quit" | "exit" -> ()
          | _ ->
              print_string "Could find command, type 'help' for all commands";
              todo ();;

todo ()
