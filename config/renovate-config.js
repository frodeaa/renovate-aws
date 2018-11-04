module.exports = {
  onboardingConfig: { extends: ['config:base'] },
  repositories: process.env.RENOVATE_REPOSITORIES ?
    process.env.RENOVATE_REPOSITORIES.split(",").map(v => v.trim()) : []
};