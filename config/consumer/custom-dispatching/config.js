const BATCH_SIZE = parseInt(process.env.BATCH_SIZE) || 100;
const MU_CALL_SCOPE_ID_INITIAL_SYNC = process.env.MU_CALL_SCOPE_ID_INITIAL_SYNC || 'http://redpencil.data.gift/id/concept/muScope/deltas/consumer/initialSync';
const BYPASS_MU_AUTH_FOR_EXPENSIVE_QUERIES = process.env.BYPASS_MU_AUTH_FOR_EXPENSIVE_QUERIES == 'true' ? true : false;

const MAX_DB_RETRY_ATTEMPTS = parseInt(process.env.MAX_DB_RETRY_ATTEMPTS || 5);
const Y_ATTEMPTS = parseInt(process.env.MAX_REASONING_RETRY_ATTEMPTS || 5);
const SLEEP_BETWEEN_BATCHES = parseInt(process.env.SLEEP_BETWEEN_BATCHES || 1000);
const SLEEP_TIME_AFTER_FAILED_REASONING_OPERATION = parseInt(process.env.SLEEP_TIME_AFTER_FAILED_REASONING_OPERATION || 10000);
const SLEEP_TIME_AFTER_FAILED_DB_OPERATION = parseInt(process.env.SLEEP_TIME_AFTER_FAILED_DB_OPERATION || 60000);
const DELETE_GRAPH = process.env.DELETE_GRAPH || `http://mu.semte.ch/graphs/delete-op-public`;
const TARGET_GRAPH = process.env.TARGET_GRAPH || `http://mu.semte.ch/graphs/public`;
const TARGET_DATABASE_ENDPOINT = process.env.TARGET_DATABASE_ENDPOINT || 'http://database:8890/sparql';
const DCR_LANDING_ZONE_GRAPH = process.env.DCR_LANDING_ZONE_GRAPH

module.exports = {
  BATCH_SIZE,
  MU_CALL_SCOPE_ID_INITIAL_SYNC,
  BYPASS_MU_AUTH_FOR_EXPENSIVE_QUERIES,
  MAX_DB_RETRY_ATTEMPTS,
  Y_ATTEMPTS,
  SLEEP_BETWEEN_BATCHES,
  SLEEP_TIME_AFTER_FAILED_DB_OPERATION,
  SLEEP_TIME_AFTER_FAILED_REASONING_OPERATION,
  DELETE_GRAPH,
  TARGET_GRAPH,
  TARGET_DATABASE_ENDPOINT,
  DCR_LANDING_ZONE_GRAPH
};