# Makefile

lint:
	@echo "Running linter..."
	@npm run lint || (echo "Linting failed. Please fix the linting errors before committing." && exit 1)

format:
	@echo "Running formatter..."
	@npm run format || (echo "Formatting failed. Please fix the formatting errors before committing." && exit 1)

precommit: lint format
	@echo "All checks passed. Ready to commit."
