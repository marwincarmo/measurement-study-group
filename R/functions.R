library(htmltools)

# From Malcolm Barrett
# https://github.com/laRusers/socalr.org
# https://socalr.org/

as_card <- function(event_name, group_name, link, img_src, ...) {
    tags$div(
        class = "card",
        tags$img(class="card-img",
                 src=img_src,
                 style="width:50px;
                        float:left"),
        tags$a(
            href = link,
            class = "action_link",
            div(
                class = "container",
                tags$div(group_name, class = "card-group"),
                tags$div(event_name, class = "card-header")
            )
        )
    )
}

# From Ijeamaka Anyeme
# https://github.com/Ijeamakaanyene/ijeamaka-anyene
# https://ijeamaka-anyene.netlify.app


create_proj_card <- function(img_src, url, title, text, text2){
    tags$div(
        href = url,
        class = "action_link",
        class = "card",
        tags$img(class="card-img",
                 src=img_src,
                 style="width:50px;"),
        tags$a(
            href = url,
            class = "action_link",
        tags$div(
            class = "card-body",
            (
                a(title, class = "card-header")),
            p(class = "card-text",
              text)
        )
    ))
    
}
# twitter_url, linkedin_url, scholar_url
profile_card <- function(img_src, name, title, email, description, website, twitter, linkedin) {
    tags$div(
        class = "card-profile",
        tags$img(src=img_src,
                 style="width:100%"),
        tags$h1(name),
        p(title, class="title-profile"),
        p(description, class="text-profile"),
        a(target="_blank", 
          href=email,
          class="fas fa-envelope",
          class="card-icon"),
        a(target="_blank", 
          href=website,
          class="card-icon",
          class=if (stringr::str_detect(website, "medium")) {
              "fab fa-medium"
          } else {
              "fas fa-globe"
          }
          ),
        a(target="_blank", 
          href=twitter,
          class="fa fa-twitter",
          class="card-icon"),
        a(target="_blank", 
          href=linkedin,
          class="fa fa-linkedin",
          class="card-icon")
           )

}