import oscP5.*;
import netP5.*;

import twitter4j.util.*;
import twitter4j.*;
import twitter4j.management.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.auth.*;

  OscP5 oscP5 = new OscP5(this, 12000);
  NetAddress myRemoteLocation = new NetAddress("127.0.0.1", 12000); //this computer
  NetAddress thisRemoteLocation = new NetAddress("192.168.3.4", 9000); //audio computer

  String[] keywordArray = {"#unscene"};

public void setup() {
  size(800, 400);

  
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("Z6cAnIyCNpJPEsuwmQ6pLpRxh");
  cb.setOAuthConsumerSecret("G9FCZz3TW9FpEA6ZiqonqkvpGpD4AsXD1DAWh20sfYW9gdll1b");
  cb.setOAuthAccessToken("17147907-3fLIHeJ5h9T7umu2JhBBCwts5tk0bNKIVpn0xiehj");
  cb.setOAuthAccessTokenSecret("xRJKjoY9zJOj9mKc5VKv0oG3okzfjPL7Bw4GwMSxxfghK");
  
  StatusListener listener = new StatusListener(){
        public void onStatus(Status status) {

          OscMessage statusMsg = new OscMessage("/status");
          statusMsg.add(status.getText());
          //OscMessage lengthMsg = new OscMessage("/length");
          statusMsg.add(status.getText().length());
          
          OscMessage userMsg = new OscMessage("/user");
          userMsg.add(status.getUser().getName());
          
          OscMessage locationMsg = new OscMessage("/location");
          //locationMsg.add(status.getPlace().getGeometryCoordinates());
          locationMsg.add(status.getUser().getLocation());
          //locationMsg.add(status.getGeoLocation().getLongitude());
          
          OscMessage timeMsg = new OscMessage("/timestamp");
          timeMsg.add(status.getCreatedAt().getTime());
          
          oscP5.send(statusMsg, myRemoteLocation);
          oscP5.send(statusMsg, thisRemoteLocation);
          //oscP5.send(lengthMsg, myRemoteLocation);
          oscP5.send(userMsg, myRemoteLocation);
          oscP5.send(locationMsg, myRemoteLocation);
          oscP5.send(timeMsg, myRemoteLocation);
          //System.out.println(status.getUser().getName() + " : " + status.getText() + status.getUser().getLocation() + status.getGeoLocation());
          }
        public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
        public void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
        public void onException(Exception ex) {
            ex.printStackTrace();
        }
    @Override
    public void onScrubGeo(long arg0, long arg1) {
      // TODO Auto-generated method stub  
      }
    @Override
    public void onStallWarning(StallWarning arg0) {
      // TODO Auto-generated method stub
      }
    };
    TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
    twitterStream.addListener(listener);
    
      FilterQuery searchString = new FilterQuery();      
      searchString.track(keywordArray);
      twitterStream.filter(searchString);
      
  }

public void draw() {
  background(0);
  }

public void getNewTweets() {

  }

