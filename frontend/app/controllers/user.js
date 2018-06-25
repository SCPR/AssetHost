/* eslint-disable ember/avoid-leaking-state-in-ember-objects */

import Controller            from '@ember/controller';
import { inject as service } from '@ember/service';
// import Promise               from 'rsvp';

export default Controller.extend({
  ajax: service(),
  resources: ["assets", "outputs", "users"],
  abilities: ["read", "write"],
  session:      service(),
  store:        service(),
  paperToaster: service(),
  actions: {
    destroyUser(){
      const model = this.get('model');
      model.destroyRecord()
           .then(()  => model.reload())
           .then(()  => this.get('paperToaster').show('User deleted successfully.', { toastClass: 'application-toast' }))
           .catch(() => this.get('paperToaster').show('Failed to delete user.', { toastClass: 'application-toast' }));
    },
    selectAllToken(){
      const el = document.querySelector('#input-user__api-token');
      if(!el) return;
      el.select();
    },
    destroyPermission(permission){
      const permissions = this.get('model.permissions'),
            index         = permissions.indexOf(permission);
      if(index > -1) permissions.removeAt(index);
    },
    addPermission(){
      this.get('model.permissions').pushObject({
        resource:  this.get('resources')[0],
        abilities: this.get('abilities')[0]
      });
    },
    saveUser(){
      const model = this.get('model');
      model.save()
           .then(()  => model.reload())
           .then(()  => this.get('paperToaster').show('User saved successfully.', { toastClass: 'application-toast' }))
           .catch(() => this.get('paperToaster').show('Failed to save user.', { toastClass: 'application-toast' }));
    },
    generateToken(){
      const user = this.get('model');
      if(!user) return;
      const adapter           = this.get('store').adapterFor('application'),
          { host, namespace } = adapter,
            url               = [ `${location.protocol}//${host || location.host}`, namespace, 'authenticate', user.id  ].filter(x => x).join('/');
            adapter.ajax(url, 'GET')
             .then(result => {
               user.set('apiToken', result.jwt);
             })
             .catch(() => {
               this.get('paperToaster').show('Failed to generate API token.');
             });
    },
    sort({draggedItem, targetList, targetIndex, sourceIndex}){
      targetList.removeAt(sourceIndex);
      targetList.insertAt(targetIndex, draggedItem);
    }
  }
});

