import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'ul',
  channel: Ember.inject.service(),
  chan: null,

  setupChannel: function(){
    this.set('chan', this.get('channel').connect());
  }.on('init')
});
