package com.revature;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        //Scanner scanner = new Scanner(System.in);
        //scanner.close();

        /*
        InputStreamReader isr = null;
        BufferedReader br = null;
        try {
            isr = new InputStreamReader(System.in);
            br = new BufferedReader(isr);
            
            String input = br.readLine();
            System.out.println(input);
        } catch (IOException exception) {
            exception.getStackTrace();
        } finally {
            try {
                br.close();
                isr.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        */

        try(
            InputStreamReader isr = new InputStreamReader(System.in);
            BufferedReader br = new BufferedReader(isr)
        ) {
            String input = br.readLine();
            System.out.println(input);
        } catch (IOException exception) {
            exception.printStackTrace();
        }
    }
}
