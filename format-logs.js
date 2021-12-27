const events = require('events');
const fs = require('fs');
const readline = require('readline');

(async function processLineByLine() {
  try {
    const rl = readline.createInterface({
      input: fs.createReadStream('samples/reflections.log'),
      crlfDelay: Infinity
    });

    rl.on('line', (line) => {
      let parts = line.split(';');
      if (parts[1] == 'A') {
        fs.appendFileSync('samples/reflections.n2k',parts[2] + "\r\n", 'utf8');
        console.log(`Line from file: ${parts[2]}`);
      }
      if (parts[1] == 'N') {
        fs.appendFileSync('samples/reflections.n0183',parts[2] + "\r\n", 'utf8');
        console.log(`Line from file: ${parts[2]}`);
      }
    });

    await events.once(rl, 'close');

  } catch (err) {
    console.error(err);
  }
})();
