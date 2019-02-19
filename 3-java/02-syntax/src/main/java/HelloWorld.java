import java.io.FileNotFoundException;

class HelloWorld {	
	// @input args is a varargs example
	public static void main (String ...args) {
		try {
			int argsLength = args.length;
			System.out.println("number of args: " + argsLength);
			if (argsLength > 0) {
				System.out.println("Hello, " + args[0]);
			}		
			
			// Can pass in any number of Strings and names argument will dynamically create an array
			names(0, args);
			if (argsLength == 0) {
				throw new FileNotFoundException();
			}
			System.out.println("How are you, " + args[0]);
		} catch (ArrayIndexOutOfBoundsException exception) {
			System.err.println("u dun goofed");
		} catch (Exception exception) {
			System.err.println("whoa now...");
		} 
	}
	
	public static void names (int start, String ...names) {
		int argsLength = names.length;
		for (int i = start; i < names.length; i++) {
			System.out.println(names[i]);
		}
		System.out.println(argsLength);
	}
}