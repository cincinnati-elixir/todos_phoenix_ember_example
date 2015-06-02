import Ember from 'ember';

import {Socket} from '../phoenix';

export default Ember.Service.extend({
  socket: function(){
    return new Socket("/ws");
  }
});
