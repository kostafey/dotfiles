let input = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
  const d = JSON.parse(input);
  process.stdout.write(d.session_name || d.session_id || '');
});
