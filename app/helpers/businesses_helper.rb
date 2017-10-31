module BusinessesHelper
  def tag_counts(testimonials)
    # The following counts the number of tags for the testimonials that are given
    tags = testimonials.map do |testimonial|
      testimonial.tags
    end

    tags_normalized = []

    tags.each do |tag|
      tags_normalized.push(tag[0])
    end

    tag_counts = []

    Tag.all.each do |tag|
      tag_counts << tags_normalized.count(tag)
    end

    return tag_counts
  end
end
