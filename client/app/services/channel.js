import Ember from 'ember';

import {Socket} from '../phoenix';

export default Ember.Service.extend({

  socket: function(){
    return new Socket("/ws");
  },

  connect: function(channel, topic, initialPayload={}){
    let socket = new Socket("/ws");
    socket.connect();
    let chan = socket.channel(`${channel}:${topic}`, initialPayload);

    chan.join().receive("ok", chan => {
      console.log("Success!");
    });
    return chan;
  }
});

