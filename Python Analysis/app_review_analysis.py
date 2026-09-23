import pandas as pd

# Load the raw app review data
file_path = "Raw Data/GooglePlay_App_Data.csv"

df = pd.read_csv(file_path)

# Show basic information
print("Dataset loaded successfully!")
print("Rows:", len(df))
print("Columns:", len(df.columns))

# Show column names
print("\nColumn names:")
print(df.columns.tolist())

# Show first 5 rows
print("\nFirst 5 rows:")
print(df.head())

# Check missing values
print("\nMissing values:")
print(df.isnull().sum())

# Check rating distribution
print("\nRating distribution:")
print(df["rating"].value_counts().sort_index())

# Check average rating
print("\nAverage rating:")
print(df["rating"].mean())

# Check review date range
print("\nReview date range:")
print(df["review_date"].min(), "to", df["review_date"].max())

# Clean review text
df["review_text"] = df["review_description"].astype(str).str.strip()

# Remove empty reviews
df = df[df["review_text"].str.len() > 0].copy()

# Convert review dates to datetime
df["review_date"] = pd.to_datetime(df["review_date"], errors="coerce")

print("\nAfter cleaning:")
print("Reviews:", len(df))

print("\nSample cleaned reviews:")
print(df[["review_text", "rating"]].head(10).to_string(index=False))

# Sentiment analysis using VADER
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

analyzer = SentimentIntensityAnalyzer()

def get_sentiment(text):
    score = analyzer.polarity_scores(text)["compound"]

    if score >= 0.05:
        return "Positive"
    elif score <= -0.05:
        return "Negative"
    else:
        return "Neutral"

df["sentiment"] = df["review_text"].apply(get_sentiment)

# Sentiment distribution
print("\nSentiment distribution:")
print(df["sentiment"].value_counts())

# Sentiment percentage
print("\nSentiment percentage:")
print((df["sentiment"].value_counts(normalize=True) * 100).round(2))

# ==============================
# THEME / ISSUE ANALYSIS
# ==============================

def assign_theme(text):
    text = text.lower()

    # Backup, sync and device migration
    if any(word in text for word in [
        "backup", "back up", "restore", "transfer",
        "switched phone", "new phone", "other devices",
        "share the data", "sync", "synchron"
    ]):
        return "Backup & Migration"

    # Login and password management
    elif any(word in text for word in [
        "password", "login", "log in", "sign in",
        "fingerprint", "thumbprint", "autofill"
    ]):
        return "Login & Password"

    # Security and privacy
    elif any(word in text for word in [
        "security", "secure", "privacy", "safe",
        "encryption"
    ]):
        return "Security"

    # Pricing / free version
    elif any(word in text for word in [
        "price", "pricing", "paid", "pay",
        "subscription", "free version", "free plan",
        "premium", "cost", "limit", "unlimited"
    ]):
        return "Pricing & Free Plan"

    # Advertising
    elif any(word in text for word in [
        "ads", "advertisement", "advertising"
    ]):
        return "Advertising"

    # Bugs / technical problems
    elif any(word in text for word in [
        "crash", "crashes", "bug", "error",
        "not working", "doesn't work", "won't work",
        "problem", "issue", "update"
    ]):
        return "Bugs & Performance"

    # Usability
    elif any(word in text for word in [
        "easy", "simple", "simplicity",
        "convenient", "user friendly",
        "easy to use", "clear appearance"
    ]):
        return "Usability"

    # Features and customization
    elif any(word in text for word in [
        "feature", "category", "categories",
        "custom", "customize", "icon",
        "autopilot", "appearance"
    ]):
        return "Features & Customization"

    else:
        return "Other"

df["theme"] = df["review_text"].apply(assign_theme)

print("\nTheme distribution:")
print(df["theme"].value_counts())

print("\nTheme distribution percentage:")
print((df["theme"].value_counts(normalize=True) * 100).round(2))

# ==============================
# THEME vs RATING & SENTIMENT
# ==============================

theme_analysis = df.groupby("theme").agg(
    reviews=("review_id", "count"),
    average_rating=("rating", "mean"),
    negative_reviews=("sentiment", lambda x: (x == "Negative").sum())
).reset_index()

theme_analysis["negative_percentage"] = (
    theme_analysis["negative_reviews"] /
    theme_analysis["reviews"] * 100
).round(2)

theme_analysis["average_rating"] = (
    theme_analysis["average_rating"].round(2)
)

theme_analysis = theme_analysis.sort_values(
    by="average_rating"
)

print("\nTheme Analysis:")
print(theme_analysis.to_string(index=False))

# ==============================
# EXPORT ANALYZED DATA
# ==============================

output_file = r"C:\Users\owner\OneDrive\Desktop\App Analysis Review\Excel Analysis\App_Review_Analyzed.xlsx"
df.to_excel(output_file, index=False)

print("\nAnalyzed dataset exported successfully!")
print("Saved to:", output_file)