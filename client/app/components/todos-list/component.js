import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'ul',
  channel: Ember.inject.service(),
  chan: null,

  setupChannel: function(){
    this.set('chan', this.get('channel').connect());

    this.chan.on("new_todo", todo => {
      console.log("Recieved new TODO!");
      console.log(todo);
      this.get('store').push('todo', todo.todo);
    });
  }.on('init')
});
