package plugin;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import javax.websocket.Session;
import org.jivesoftware.openfire.MessageRouter;
import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.container.PluginManager;
import org.jivesoftware.openfire.event.SessionEventDispatcher;
import org.jivesoftware.openfire.event.SessionEventListener;
import org.jivesoftware.util.JiveGlobals;
import org.xmpp.packet.JID;
import org.xmpp.packet.Message;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Shubham
 */
public class GitInPlugin {
    private static String COMMAND="";
    private static String ADDRESS="";
    private JID serverAddress;
    private MessageRouter router;
    private static final String ENABLED = "plugin.gitin.enabled";
    private GitInSessionEventListener listener = new GitInSessionEventListener();
    public void initializePlugin(PluginManager manager,File pluginDirectory){
        serverAddress = new JID(XMPPServer.getInstance().getServerInfo().getXMPPDomain());
        router = XMPPServer.getInstance().getMessageRouter();
        
        SessionEventDispatcher.addListener(listener);
    }
    
    public void destroyPlugin(){
        SessionEventDispatcher.removeListener(listener);
        
        listener = null;
        serverAddress = null;
        router = null;
    }
    public String runCommand() throws IOException{
       return RunC.runc(COMMAND);
    }
    
    public boolean isEnabled(){
        return JiveGlobals.getBooleanProperty(ENABLED, false);
    }
    
    public String getCommand() {
      return JiveGlobals.getProperty(COMMAND, "");
    }
    
    public void setCommand(String command){
        COMMAND=command;
    }
    
    public String getAddress()
    {
    	return JiveGlobals.getProperty(ADDRESS, "");
    }
    
    public void setAddress(String address){
        ADDRESS=address;
    }
    
    public void setEnabled(boolean enable){
        JiveGlobals.setProperty(ENABLED, enable ? Boolean.toString(true):Boolean.toString(false));
    }
    private class GitInSessionEventListener implements SessionEventListener {


        public void sessionCreated(Session session) {
            if(isEnabled()){
                final Message message = new Message();
            //    message.setTo(session.getAddress());
             //   message.setFrom(serverAddress);
              //  message.setCommand(getCommand());
            }
        }

        @Override
        public void sessionDestroyed(org.jivesoftware.openfire.session.Session sn) {
            throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }

        @Override
        public void anonymousSessionCreated(org.jivesoftware.openfire.session.Session sn) {
            throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }

        @Override
        public void anonymousSessionDestroyed(org.jivesoftware.openfire.session.Session sn) {
            throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }

        @Override
        public void resourceBound(org.jivesoftware.openfire.session.Session sn) {
            throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }

        @Override
        public void sessionCreated(org.jivesoftware.openfire.session.Session sn) {
            throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }

        
    }
    
}
