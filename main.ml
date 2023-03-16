let help =
"help
create [title]
delete [title]
list
read [title]
edit [title]"

let extracted_args inp = Str.split (Str.regexp " ") inp

let multiline_user_input content =
	let oc = open_out "/tmp/note.txt" in
	Printf.fprintf oc "%s" content;
	close_out oc;

	Sys.command "vim /tmp/note.txt";

	let ic = open_in "/tmp/note.txt" in
	let input = really_input_string ic (in_channel_length ic) in
	close_in ic;
	input


let rec todo () =
	print_string "\nWelcome to the todo list: ";

	let inp = read_line() in
	let args = extracted_args inp in
	let command = List.nth args 0 in

	match command with
		| "help" ->
			print_string help;
			todo ()
		| "create" ->
			let filename = Printf.sprintf "notes/%s.txt" (List.nth args 1) in

			if not (Sys.file_exists filename) then
				let oc = open_out (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in
				Printf.fprintf oc "%s" (multiline_user_input "");
				close_out oc;
				print_string "File created"
			else
				print_string "File already exists";

			todo ()
		| "delete" ->
			let filename = Printf.sprintf "notes/%s.txt" (List.nth args 1) in

			if Sys.file_exists filename then
				let () = Sys.remove filename in
				print_string "File deleted"
			else
				print_string "File doesn't exist";

			todo ()
		| "list" ->
			let files = Sys.readdir "notes" in
			let notes = List.filter (fun file -> Str.last_chars file 4 = ".txt") (Array.to_list files) in
			let notes_string = String.concat "\n" (List.map (fun file -> String.sub file 0 ((String.length file) - 4)) notes) in

			print_string notes_string;

			todo ()
		| "read" ->
			let ic = open_in (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in
			let note = really_input_string ic (in_channel_length ic) in

			print_string note;
			flush stdout;
			close_in ic;

			todo ()
		| "edit" ->
			let filename = (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in

			if Sys.file_exists filename then
				let ic = open_in (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in
				let note_string = really_input_string ic (in_channel_length ic) in
				close_in ic;

				let oc = open_out (Printf.sprintf "notes/%s.txt" (List.nth args 1)) in
				Printf.fprintf oc "%s" (multiline_user_input note_string);
				close_out oc;
				print_string "File updated"
			else
				print_string "File doesn't exist";

			todo ()
		| "quit" | "exit" -> ()
		| _ ->
			print_string "Could find command, type 'help' for all commands";
			todo ();;

todo ()
