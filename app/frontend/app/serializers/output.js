import ApplicationSerializer from './application';

export default ApplicationSerializer.extend({
  _normalizeRecord(record){
    const attributes = Object.assign({}, record),
          type       = 'output',
          id         = attributes.id;
    delete attributes.id;
    return { id, type, attributes };
  }
});