import DS from 'ember-data';
import Ember from 'ember';

export default DS.ActiveModelAdapter.extend({
  namespace: 'api',
  channelService: Ember.inject.service("channel"),
  channel: null,

  setupChannel: function(){
    this.set('channel', this.get('channelService').connect('todos','list', {}));

    this.channel.on("todo", todo => {
      console.log("Received updated TODO!");
      console.log(todo);
      this.get('store').push('todo', todo.todo);
    });

    this.channel.on("deleted_todo", todo => {
      console.log("Received deleted TODO!");
      console.log(todo);
      let record = this.get('store').getById('todo', todo.todo.id);
      if(record) {
        this.get('store').unloadRecord(record);
      }
    });

  }.on('init')
});
