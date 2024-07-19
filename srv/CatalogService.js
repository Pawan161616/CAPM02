//IN order to use generic function for a service create as js file with same name (like here CatalogService.js)
//write logic here.
//module.exports in nodejs allows the function to be used by other files as global function.

module.exports = async function () {
  //"this" is taking reference of all catalogService.cds file.
  const {
    EmployeeSet, AddressSet, POs
  } = this.entities

  this.before('UPDATE', EmployeeSet, (req, res) => {
    if (parseFloat(req.data.salaryAmount) >= 1000) {
      req.error(500, "more thean 1lack");
    }

  });
  this.before('UPDATE', AddressSet, (req, res) => {
    if (req.data.COUNTRY === 'IN') {
      req.error(500, "India is a big country to play in this league, try something else");
    }
  });
//bug
  this.on('boost', async req => {
    try {
      const ID = req.params[0];
      console.log('Your Puchase order with ID --->' + ID + "will be boosted");
      const tx = cds.tx(req);
      await tx.update(POs).with({
        GROSS_AMOUNT: { '+=': 20000 },
        NOTE: "Boosted !"
      }).where(ID);
      return "Boost was success!"
    } catch (error) {
      return "Error" + error.toString();
    }
  });
//bug
  this.on('largestOrder', async (req) => {
    const tx = cds.tx(req);
    try {
      console.log("hello,we are here");
      let response = await tx.read(POs).orderBy({
        GROSS_AMOUNT: 'desc'
      }).limit(1);
      return response;
    } catch (error) {
      return "Error:" + error.toString();
    }

  });
}