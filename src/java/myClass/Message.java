package myClass;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Message {

    private String sender;
    private String receiver;
    private String msg;
    private Timestamp msgTime;
    private byte[] senderImage;
    private byte[] receiverImage;

    public Message() {
    }

    // Parameterized constructor
    public Message(String sender, String receiver, String msg, Timestamp msgTime, byte[] senderImage, byte[] receiverImage) {
        this.sender = sender;
        this.receiver = receiver;
        this.msg = msg;
        this.msgTime = msgTime;
        this.senderImage = senderImage;
        this.receiverImage = receiverImage;
    }

    public String getSender() {
        return this.sender;
    }

    public String getReceiver() {
        return this.receiver;
    }

    public String getMsg() {
        return this.msg;
    }

    public Timestamp getMsgTime() {
        return this.msgTime;
    }

    public String getFormattedMsgTime() {
        if (msgTime != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm | dd/MM/yyyy");
            return dateFormat.format(new Date(msgTime.getTime()));
        } else {
            return null;
        }
    }

    public byte[] getSenderImage() {
        return this.senderImage;
    }

    public byte[] getReceiverImage() {
        return this.receiverImage;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public void setMsgTime(Timestamp msgTime) {
        this.msgTime = msgTime;
    }

    public void setSenderImage(byte[] senderImage) {
        this.senderImage = senderImage;
    }

    public void setReceiverImage(byte[] receiverImage) {
        this.receiverImage = receiverImage;
    }
}
