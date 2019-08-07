module.exports = function (api) {
  api.cache(true); // makes jest not blow upp

  const presets = ["react-app"];
  return {
    presets
  };
};
