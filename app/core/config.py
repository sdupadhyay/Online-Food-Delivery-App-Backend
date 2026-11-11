from urllib.parse import urlparse, urlunparse
from pydantic import computed_field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """
    Application Settings.
    Reads environment variables from a .env file or the host environment.
    Provides type-safe configuration with automatic validation.
    """
    PROJECT_NAME: str = "Online Food Delivery API"
    API_V1_STR: str = "/api/v1"
    ENVIRONMENT: str = "development"

    # Database: Must be provided via .env (no hardcoded credentials)
    DATABASE_URL: str

    @computed_field
    @property
    def ASYNC_DATABASE_URL(self) -> str:
        """
        1. Normalizes scheme to 'postgresql+asyncpg://' for SQLAlchemy's async engine.
        2. Strips query parameters (e.g. ?sslmode=require&channel_binding=require)
           because asyncpg handles SSL via connect_args={'ssl': True} rather than URL query params.
        """
        url = self.DATABASE_URL
        if url.startswith("postgres://"):
            url = url.replace("postgres://", "postgresql+asyncpg://", 1)
        elif url.startswith("postgresql://") and not url.startswith("postgresql+asyncpg://"):
            url = url.replace("postgresql://", "postgresql+asyncpg://", 1)

        # Strip URL query params that asyncpg does not accept in DSN
        parsed = urlparse(url)
        clean_url = urlunparse((parsed.scheme, parsed.netloc, parsed.path, '', '', ''))
        return clean_url

    # Security & JWT Token
    SECRET_KEY: str = "supersecretkey_please_replace_this_in_production_with_a_secure_token"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7 days

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=True,
        extra="ignore"
    )


settings = Settings()
