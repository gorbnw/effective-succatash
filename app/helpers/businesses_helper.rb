module BusinessesHelper
  def tag_counts(testimonials)
    # The following counts the number of tags for the testimonials that are given
    testimonial_tags = testimonials.map do |testimonial|
      testimonial.tags
    end

    tags_normalized = []

    testimonial_tags.each do |tags|
      tags.each do |tag|
        tags_normalized.push(tag)
      end
    end

    tag_counts = []

    Tag.all.each do |tag|
      tag_counts << tags_normalized.count(tag)
    end

    descriptions = Tag.all.map { |tag| tag.description }

    tag_counts_array_of_arrays = [["Tag", "Count"]]

    i = 0

    while i < descriptions.length
      tag_counts_array_of_arrays << [descriptions[i], tag_counts[i]]
      i += 1
    end

    return tag_counts_array_of_arrays
  end
end

private
