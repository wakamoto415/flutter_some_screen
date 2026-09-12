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

  const filePath = input?.tool_input?.file_path;
  if (!filePath) process.exit(0);

  const rulesPath = path.join(__dirname, 'rules.json');
  let rules;
  try {
    rules = JSON.parse(fs.readFileSync(rulesPath, 'utf8'));
  } catch {
    process.exit(0);
  }

  const ext = path.extname(filePath);
  const languages = rules.languages || {};
  const lang = Object.values(languages).find((l) => (l.extensions || []).includes(ext));
  if (!lang || !lang.lint) process.exit(0);

  const command = lang.lint.replaceAll('{file}', filePath);

  try {
    execSync(command, { stdio: 'pipe' });
  } catch (err) {
    const output = (err.stdout?.toString() || '') + (err.stderr?.toString() || '');
    process.stderr.write(`post-edit-lint: "${command}" reported issues:\n${output}\n`);
  }

  process.exit(0);
}

main();
