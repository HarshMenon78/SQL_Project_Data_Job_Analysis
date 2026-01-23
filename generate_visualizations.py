import os
print("RUNNING FROM:", os.getcwd())

import pandas as pd
import matplotlib.pyplot as plt
import os

# Set matplotlib to use non-interactive backend
import matplotlib
matplotlib.use('Agg')

# -----------------------------
# Paths
# -----------------------------
CSV_DIR = "results_csv"
IMG_DIR = "images"

os.makedirs(IMG_DIR, exist_ok=True)
print(f"Images will be saved to: {os.path.abspath(IMG_DIR)}")

# -----------------------------
# 1. Top Paying Data Analyst Jobs
# -----------------------------
df1 = pd.read_csv(f"{CSV_DIR}/top_paying_jobs.csv")
df1 = df1.sort_values("salary_year_avg")
print(f"Creating visualization 1... (rows: {len(df1)})")

plt.figure()
plt.barh(df1["company_name"], df1["salary_year_avg"])
plt.xlabel("Average Yearly Salary (USD)")
plt.title("Top 10 Highest Paying Data Analyst Jobs (Remote)")
plt.tight_layout()
img_path = f"{IMG_DIR}/1_top_paying_jobs.png"
plt.savefig(img_path)
print(f"✓ Saved: {img_path}")
plt.close()

# -----------------------------
# 2. Skills Required for Top Paying Jobs
# -----------------------------
df2 = pd.read_csv(f"{CSV_DIR}/top_pay_jobs_skills.csv")
skill_freq = df2["skills"].value_counts().head(10)
print(f"Creating visualization 2... (skills: {len(skill_freq)})")

plt.figure()
skill_freq.plot(kind="bar")
plt.ylabel("Frequency")
plt.title("Most Common Skills in Top Paying Data Analyst Jobs")
plt.tight_layout()
img_path = f"{IMG_DIR}/2_top_paying_jobs_skills.png"
plt.savefig(img_path)
print(f"✓ Saved: {img_path}")
plt.close()

# -----------------------------
# 3. Most In-Demand Data Analyst Skills
# -----------------------------
df3 = pd.read_csv(f"{CSV_DIR}/top_skills_DA.csv")
print(f"Creating visualization 3... (rows: {len(df3)})")

plt.figure()
plt.barh(df3["skills"], df3["job_count"])
plt.xlabel("Job Count")
plt.title("Top 10 Most In-Demand Data Analyst Skills")
plt.tight_layout()
img_path = f"{IMG_DIR}/3_top_demanded_skills.png"
plt.savefig(img_path)
print(f"✓ Saved: {img_path}")
plt.close()

# -----------------------------
# 4. Top Paying Skills by Average Salary
# -----------------------------
df4 = pd.read_csv(f"{CSV_DIR}/top_salary_skills.csv")
df4 = df4.sort_values("avg_salary")
print(f"Creating visualization 4... (rows: {len(df4)})")

plt.figure()
plt.barh(df4["skills"], df4["avg_salary"])
plt.xlabel("Average Salary (USD)")
plt.title("Top Paying Data Analyst Skills")
plt.tight_layout()
img_path = f"{IMG_DIR}/4_top_skills_by_salary.png"
plt.savefig(img_path)
print(f"✓ Saved: {img_path}")
plt.close()

# -----------------------------
# 5. Most Optimal Skills (Demand vs Salary)
# -----------------------------
df5 = pd.read_csv(f"{CSV_DIR}/top_optimal_skills.csv")
print(f"Creating visualization 5... (rows: {len(df5)})")

plt.figure()
plt.scatter(df5["job_count"], df5["avg_salary"])

for _, row in df5.iterrows():
    plt.text(row["job_count"], row["avg_salary"], row["skills"], fontsize=8)

plt.xlabel("Job Demand")
plt.ylabel("Average Salary (USD)")
plt.title("Most Optimal Data Analyst Skills (Demand vs Pay)")
plt.tight_layout()
img_path = f"{IMG_DIR}/5_top_optimal_skills.png"
plt.savefig(img_path)
print(f"✓ Saved: {img_path}")
plt.close()

# -----------------------------
# 6. Salary Distribution of Latest Jobs
# -----------------------------
df6 = pd.read_csv(f"{CSV_DIR}/latest_jobs.csv")
print(f"Creating visualization 6... (rows: {len(df6)})")

plt.figure()
plt.hist(df6["salary_year_avg"])
plt.xlabel("Salary (USD)")
plt.ylabel("Frequency")
plt.title("Salary Distribution of Latest Data Analyst Jobs")
plt.tight_layout()
img_path = f"{IMG_DIR}/6_latest_jobs.png"
plt.savefig(img_path)
print(f"✓ Saved: {img_path}")
plt.close()

print("\n✓ All visualizations completed successfully!")
plt.close()

print("✅ All visualizations generated successfully!")