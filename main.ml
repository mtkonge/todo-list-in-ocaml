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

	Sys.command "vim /tmp/note.txt" |> ignore;

	let ic = open_in "/tmp/note.txt" in
	let input = really_input_string ic (in_channel_length ic) in
	close_in ic;
	input

let note_path name = Printf.sprintf "notes/%s.txt" name

let note_contents name =
	let ic = open_in (note_path name) in
	let note = really_input_string ic (in_channel_length ic) in
	close_in ic;
	note

let write_note name content =
	let oc = open_out (note_path name) in
	Printf.fprintf oc "%s" content;
	close_out oc

let note_exists name = Sys.file_exists (note_path name)

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
			if not (note_exists (List.nth args 1)) then begin
				write_note (List.nth args 1) (multiline_user_input "");
				print_string "File created"
			end else
				print_string "File already exists";

			todo ()
		| "delete" ->
			let filename = note_path (List.nth args 1) in

			if Sys.file_exists filename then begin
				Sys.remove filename;
				print_string "File deleted"
			end else
				print_string "File doesn't exist";

			todo ()
		| "list" ->
			let files = Sys.readdir "notes" in
			let filtered_notes = List.filter (fun file -> Str.last_chars file 4 = ".txt") (Array.to_list files) in
			let notes_without_extensions = List.map (fun file -> String.sub file 0 ((String.length file) - 4)) filtered_notes in
			let notes_string = String.concat "\n" notes_without_extensions in

			print_string notes_string;

			todo ()
		| "read" ->
			if (note_exists (List.nth args 1)) then begin
				print_string (note_contents (List.nth args 1));
			end else
				print_string "File doesn't exist\n";
			todo ()
		| "edit" ->
			let note = List.nth args 1 in

			if note_exists note then
				let note_string = note_contents note in
				write_note note (multiline_user_input note_string);

				print_string "File updated"
			else
				print_string "File doesn't exist";

			todo ()
		| "quit" | "exit" -> ()
		| _ ->
			print_string "Could find command, type 'help' for all commands";
			todo ();;

todo ()
