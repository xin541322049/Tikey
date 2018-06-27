package cn.tikey.exceptions;

public class NoMemberException extends RuntimeException {
    public NoMemberException(String message){
        super("No member registered with this email "+message);
    }
}
