package cn.tikey.exceptions;

public class WrongPasswordException extends RuntimeException{

    public WrongPasswordException(){
        super("Wrong password while logging in");
    }
}
