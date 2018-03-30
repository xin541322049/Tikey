package cn.tikey.exceptions;

public class NoTicketException extends RuntimeException {
    public NoTicketException(){
        super("There is no more ticket");
    }
}
