import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.jdbc.datasource.DriverManagerDataSource
import org.flywaydb.core.Flyway

@Configuration
class FlywayConfig(
        @Value("\${spring.datasource.url}") private val databaseUrl: String,
        @Value("\${spring.datasource.username}") private val databaseUsername: String,
        @Value("\${spring.datasource.password}") private val databasePassword: String
) {

    @Bean(initMethod = "migrate")
    fun flyway(): Flyway {
        return Flyway.configure()
                .dataSource(dataSource())
                .locations("classpath:db/migration")
                .load()
    }

    @Bean
    fun dataSource(): DriverManagerDataSource {
        val dataSource = DriverManagerDataSource()
        dataSource.setDriverClassName("org.postgresql.Driver")
        dataSource.url = databaseUrl
        dataSource.username = databaseUsername
        dataSource.password = databasePassword
        return dataSource
    }
}
