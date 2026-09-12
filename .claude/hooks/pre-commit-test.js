const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

function readStdin() {
  try {
    return fs.readFileSync(0, 'utf8');
  } catch {
    return '';
  }
}

function main() {
  const raw = readStdin();
  let input;
  try {
    input = JSON.parse(raw);
  } catch {
    process.exit(0);
  }

  const command = input?.tool_input?.command || '';
  if (!command.includes('git commit')) process.exit(0);

  const rulesPath = path.join(__dirname, 'rules.json');
  let rules;
  try {
    rules = JSON.parse(fs.readFileSync(rulesPath, 'utf8'));
  } catch {
    process.exit(0);
  }

  const languages = rules.languages || {};
  const projectRoot = path.resolve(__dirname, '..', '..');

  for (const [name, lang] of Object.entries(languages)) {
    if (!lang.test) continue;
    try {
      execSync(lang.test, { cwd: projectRoot, stdio: 'pipe' });
    } catch (err) {
      const output = (err.stdout?.toString() || '') + (err.stderr?.toString() || '');
      process.stderr.write(`pre-commit-test: "${lang.test}" (${name}) failed:\n${output}\n`);
      process.exit(2);
    }
  }

  process.exit(0);
}

main();
