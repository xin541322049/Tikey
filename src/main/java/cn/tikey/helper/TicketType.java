package cn.tikey.helper;

public enum TicketType {
    Stall, Second, Third, Fourth;
    public static TicketType getType(String type){
        if(type.equals("stall")){
            return TicketType.Stall;
        }
        if(type.equals("second")){
            return TicketType.Second;
        }
        if(type.equals("third")){
            return TicketType.Third;
        }
        if(type.equals("fourth")){
            return TicketType.Fourth;
        }
        return null;
    }
}
